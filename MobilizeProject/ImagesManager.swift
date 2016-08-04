//
//  ImagesManager.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 03/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

class ImagesManager {

    let network: Network
    var requestOperations = [Int: WeakObject<NSOperation>]()
    let operationQueue = NSOperationQueue()
    
    init(network: Network) {
        self.network = network
        operationQueue.name = "Image Loader"
        operationQueue.qualityOfService = .Background
        operationQueue.maxConcurrentOperationCount = 2
    }
    
    func image(withRequest request: Int, url: String, complete: UIImageOptionalVoid) {
        let newOperation = ImageDownloadOperation(url: url, network: network, complete: complete)
        if let operation = requestOperations[request]?.object {
            operation.cancel()
        }
        requestOperations[request] = WeakObject(object: newOperation)
        operationQueue.addOperation(newOperation)
    }
    
}