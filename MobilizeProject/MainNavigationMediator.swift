//
//  MainNavigationMediator.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

protocol MainNavigationMediatorUIDelegate: class {
    
}

class MainNavigationMediator {
    
    weak var uiDelegate: MainNavigationMediatorUIDelegate?
    
    weak var mainMediator: MainMediator?
    weak var imagesCollectionMediator: ImagesCollectionMediator?
    
    init(uiDelegate: MainNavigationMediatorUIDelegate) {
        self.uiDelegate = uiDelegate
    }
    
}

extension MainNavigationMediator: MainMediatorDelegate {
    
}

extension MainNavigationMediator: ImagesCollectionMediatorDelegate {
    
}