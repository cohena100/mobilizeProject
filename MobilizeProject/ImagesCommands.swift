//
//  ImagesCommands.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImagesCommands  {
    
    let networkProxy: INetworkProxy
    let url = "https://s3-us-west-2.amazonaws.com/ios-homework/ios/feed.json"
    var images = [ImageItem]()
    
    init(networkProxy: INetworkProxy) {
        self.networkProxy = networkProxy
    }
    
    func setup(success: () -> (), failure: (error: NSError) -> ()) {
        networkProxy.get(url, success: { (json) in
            let jsonArray = json as! [[String: AnyObject]]
            var newImages = [ImageItem]()
            for element in jsonArray {
                let e = element as! [String: String]
                let imageThumb = e["imageThumb"]!
                let original = e["original"]!
                let newElement = ImageItem(imageThumb: NSURL(string: imageThumb)!, original: NSURL(string: original)!, thumbnail: nil)
                newImages.append(newElement)
            }
            self.images = newImages
            success()
            }) { (error) in
                print("error: \(error)")
                failure(error: error)
        }
    }
 
    func cache(thumbnail: UIImage, atIndexPath indexPath: NSIndexPath) {
        images[indexPath.row].thumbnail = thumbnail
    }
    
}