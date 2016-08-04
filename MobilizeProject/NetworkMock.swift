//
//  NetworkMock.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 04/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class NetworkMock: Network {
    
    let jsonFeed: [[String: String]]
    
    override init() {
        jsonFeed = (0 ..< 100).map { ["imageThumb": String($0), "original": String($0)] }
        super.init()
    }
    
    override func image(forURL url: String, complete: UIImageOptionalVoid) -> () {
        let number = Int(url)!
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        switch number % 4 {
        case 0:
            view.backgroundColor = UIColor.redColor()
        case 1:
            view.backgroundColor = UIColor.greenColor()
        case 2:
            view.backgroundColor = UIColor.blueColor()
        default:
            view.backgroundColor = UIColor.brownColor()
        }
        let image = UIImage.image(from: view)
        sleep(1)
        complete(image: image)
    }
    
    override func get(url: String, success: (json: AnyObject) -> (), failure: (error: NSError) -> ()) {
        success(json: jsonFeed)
    }
    
}