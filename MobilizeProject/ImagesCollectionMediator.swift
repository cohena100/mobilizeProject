//
//  ImagesCollectionMediator.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

protocol ImagesCollectionMediatorUIDelegate: class {
    
}

protocol ImagesCollectionMediatorDelegate: class {
    
}

class ImagesCollectionMediator {
    
    weak var uiDelegate: ImagesCollectionMediatorUIDelegate?
    weak var delegate: ImagesCollectionMediatorDelegate?
    
    init(uiDelegate: ImagesCollectionMediatorUIDelegate, delegate: ImagesCollectionMediatorDelegate) {
        self.uiDelegate = uiDelegate
        self.delegate = delegate
    }
    
}