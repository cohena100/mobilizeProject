//
//  ImagesProxy.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 30/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImagesProxy {

    var imageItems = [ImageItem]()
    var imageItemsCount: Int {
        return imageItems.count
    }
    
}

extension ImagesProxy: IImagesProxy {
    
    func setup(complete: () -> ()) {
        if imageItemsCount > 0 {
            complete()
            return
        }
        let url = "https://s3-us-west-2.amazonaws.com/ios-homework/ios/feed.json"
        Network().get(url, success: { [weak self] (json) in
            let jsonArray = json as! [[String: AnyObject]]
            self?.imageItems = jsonArray.map({ (jsonItem) -> ImageItem in
                let item = jsonItem as! [String: String]
                let imageThumb = item["imageThumb"]!
                let original = item["original"]!
                let newElement = ImageItem(thumbnailURL: NSURL(string: imageThumb)!, imageURL: NSURL(string: original)!, thumbnailImage: nil)
                return newElement
            })
            complete()
        }) { (error) in
            print("error: \(error)")
            complete()
        }
    }
    
    func thumbnail(atIndexPath indexPath: NSIndexPath, complete: (thumbnail: UIImage) -> ()) {
        let imageItem = imageItems[indexPath.row]
        if imageItem.thumbnailImage != nil {
            complete(thumbnail: imageItem.thumbnailImage!)
            return
        }
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) { [weak self] in
            let imageData = NSData(contentsOfURL: imageItem.thumbnailURL)!
            let thumbnail = UIImage(data:imageData)!
            self?.imageItems[indexPath.row].thumbnailImage = thumbnail
            dispatch_async(dispatch_get_main_queue()) {
                complete(thumbnail: thumbnail)
            }
        }
        
    }
    
    func image(atIndexPath indexPath: NSIndexPath, complete: (image: UIImage) -> ()) {
        let imageItem = imageItems[indexPath.row]
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let imageData = NSData(contentsOfURL: imageItem.imageURL)!
            let image = UIImage(data:imageData)!
            dispatch_async(dispatch_get_main_queue()) {
                complete(image: image)
            }
        }
    }
    
}