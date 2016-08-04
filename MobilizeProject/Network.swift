//
//  Network.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 30/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit
import Alamofire

class Network {
    
    init() {
        
    }
    
    func image(forURL url: String, complete: UIImageOptionalVoid) -> () {
        let imageData = NSData(contentsOfURL: NSURL(string: url)!)
        guard let data = imageData else {
            complete(image: nil)
            return
        }
        complete(image: UIImage(data:data))
    }
    
    func get(url: String, success: (json: AnyObject) -> (), failure: (error: NSError) -> ()) {
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                let json = response.result.value!
                success(json: json)
            case .Failure(let error):
                failure(error: error)
            }
        }
    }
    
}

