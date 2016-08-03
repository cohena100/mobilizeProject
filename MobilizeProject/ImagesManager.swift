//
//  ImagesManager.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 03/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

class ImagesManager {

    var requestOperations = [Int: WeakObject<NSOperation>]()
    let operationQueue = NSOperationQueue()
    
    init() {
        operationQueue.name = "Image Loader"
        operationQueue.qualityOfService = .Background
        operationQueue.maxConcurrentOperationCount = 2
    }
    
    func image(withRequest request: Int, url: NSURL, complete: UIImageOptionalVoid) {
        let newOperation = ImageDownloadOperation(url: url, complete: complete)
        if let operation = requestOperations[request]?.object {
            operation.cancel()
        }
        requestOperations[request] = WeakObject(object: newOperation)
        operationQueue.addOperation(newOperation)
    }
    
}