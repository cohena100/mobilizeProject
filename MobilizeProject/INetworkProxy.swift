//
//  INetworkProxy.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 30/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

protocol INetworkProxy: class {
    
    func get(url: String, success: (json: AnyObject) -> (), failure: (error: NSError) -> ())
    
}