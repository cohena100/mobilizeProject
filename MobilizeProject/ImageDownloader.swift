//
//  ImageDownloader.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 03/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    let imageURL: NSURL
    var image: UIImage?
    let operationQueue = NSOperationQueue()
    var downloadingImage = false
    
    init(imageURL: NSURL) {
        operationQueue.name = "Image Loader"
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = .Background
        self.imageURL = imageURL
    }
    
    func sendGetImage(complete: UIImageVoid) {
        if image != nil {
            complete(image: image!)
            return
        }
        if !downloadingImage {
            self.downloadingImage = true
            operationQueue.addOperationWithBlock {
                let imageData = NSData(contentsOfURL: self.imageURL)!
                self.image = UIImage(data:imageData)
            }
        }
        operationQueue.addOperationWithBlock {
            dispatch_async(dispatch_get_main_queue()) {
                complete(image: self.image!)
            }
        }
    }
}