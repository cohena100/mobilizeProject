//
//  ImageDownloadOperation.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 03/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImageDownloadOperation: NSOperation {
    
    let url: String
    let network: Network
    var complete: UIImageOptionalVoid!
    var state = (executing: false, finished: false)
    
    init(url: String, network: Network, complete: UIImageOptionalVoid) {
        self.url = url
        self.network = network
        self.complete = complete
        super.init()
    }
    
    override var asynchronous: Bool {
        return true
    }
    
    override var executing: Bool {
        return state.executing
    }
    
    override var finished: Bool {
        return state.finished
    }
    
    override func start() {
        if cancelled {
            complete(image: nil)
            willChangeValueForKey("finished")
            state = (executing: state.executing, finished: true)
            didChangeValueForKey("finished")
            return
        }
        willChangeValueForKey("executing")
        state = (executing: true, finished: state.finished)
        didChangeValueForKey("executing")
        main()
    }
    
    override func main() {
        let image = network.image(forURL: self.url)!
        if self.cancelled {
            self.complete(image: nil)
        } else {
            self.complete(image: image)
        }
        self.willChangeValueForKey("finished")
        self.willChangeValueForKey("executing")
        self.state = (executing: false, finished: true)
        self.didChangeValueForKey("executing")
        self.didChangeValueForKey("finished")
    }
    
}