//
//  Network.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 30/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    
}

extension Network {
    
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