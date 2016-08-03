//
//  WeakObject.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 03/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

class WeakObject<T: AnyObject>: Equatable, Hashable {
    weak var object: T?
    init(object: T) {
        self.object = object
    }
    
    var hashValue: Int {
        if let object = self.object { return unsafeAddressOf(object).hashValue }
        else { return 0 }
    }
}

func == <T> (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
    return lhs.object === rhs.object
}
