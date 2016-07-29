//
//  MainMediator.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

protocol MainMediatorUIDelegate: class {
    
}

protocol MainMediatorDelegate: class {
    
}

class MainMediator {
    
    weak var uiDelegate: MainMediatorUIDelegate?
    weak var delegate: MainMediatorDelegate?
    
    init(uiDelegate: MainMediatorUIDelegate, delegate: MainMediatorDelegate) {
        self.uiDelegate = uiDelegate
        self.delegate = delegate
    }
    
}