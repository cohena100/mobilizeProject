//
//  ImageDownloadOperation.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 03/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImageDownloadOperation: NSOperation {
    
    let url: NSURL
    var complete: UIImageOptionalVoid!
    var state = (executing: false, finished: false)
    
    init(url: NSURL, complete: UIImageOptionalVoid) {
        self.url = url
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
            willChangeValueForKey("finished")
            state = (executing: state.executing, finished: true)
            didChangeValueForKey("finished")
            complete(image: nil)
            return
        }
        willChangeValueForKey("executing")
        state = (executing: true, finished: state.finished)
        didChangeValueForKey("executing")
        main()
    }
    
    override func main() {
        let imageData = NSData(contentsOfURL: self.url)!
        if cancelled {
            complete(image: nil)
        } else {
            complete(image: UIImage(data:imageData))
        }
        complete(image: UIImage(data:imageData))
        willChangeValueForKey("finished")
        willChangeValueForKey("executing")
        state = (executing: false, finished: true)
        didChangeValueForKey("executing")
        didChangeValueForKey("finished")
    }
    
}