//
//  ImagesModel.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 30/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImagesModel {

    let network: Network
    var imageItems = [ImageItem]()
    var imageItemsCount: Int {
        return imageItems.count
    }
    var thumbnailsManager: ImagesManager

    init(network: Network) {
        self.network = network
        self.thumbnailsManager = ImagesManager(network: self.network)
    }
    
    func setup(complete: VoidVoid) {
        if imageItemsCount > 0 {
            complete()
            return
        }
        let url = "https://s3-us-west-2.amazonaws.com/ios-homework/ios/feed.json"
        network.get(url, success: { [weak self] (json) in
            let jsonArray = json as! [[String: AnyObject]]
            self?.imageItems = jsonArray.map({ (jsonItem) -> ImageItem in
                let item = jsonItem as! [String: String]
                let imageThumb = item["imageThumb"]!
                let original = item["original"]!
                let newElement = ImageItem(imageURL: NSURL(string: original)!, thumbnailURL: NSURL(string: imageThumb)!, thumbnail: nil)
                return newElement
            })
            complete()
        }) { (error) in
            print("error: \(error)")
            complete()
        }
    }
    
    func thumbnail(atIndexPath indexPath: NSIndexPath, request: Int, complete: UIImageOptionalVoid) {
        let imageItem = imageItems[indexPath.row]
        if imageItem.thumbnail != nil {
            complete(image: imageItem.thumbnail!)
            return
        }
        thumbnailsManager.image(withRequest: request, url: imageItem.thumbnailURL) { [unowned self] (image) in
            if image != nil {
                self.imageItems[indexPath.row].thumbnail = image
            }
            complete(image: image)
        }
    }
    
    func image(atIndexPath indexPath: NSIndexPath, complete: UIImageVoid) {
        let imageItem = imageItems[indexPath.row]
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let image = self.network.image(forURL: imageItem.imageURL)!
            dispatch_async(dispatch_get_main_queue()) {
                complete(image: image)
            }
        }
    }

}
