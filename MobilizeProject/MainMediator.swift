//
//  MainMediator.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

protocol MainMediatorUIDelegate: class {
    func mainMediatorUIDelegateDidSelectImage(image: UIImage)
}

protocol MainMediatorDelegate: class {
    
}

class MainMediator {
    
    weak var uiDelegate: MainMediatorUIDelegate?
    weak var delegate: MainMediatorDelegate?
    let imagesCommands: ImagesCommands
    
    init(uiDelegate: MainMediatorUIDelegate, delegate: MainMediatorDelegate) {
        self.uiDelegate = uiDelegate
        self.delegate = delegate
        self.imagesCommands = Model.sharedInstance.factory.getImagesCommands()
    }
    
    func didSelectImage(AtIndexPath indexPath: NSIndexPath) {
        imagesCommands.image(atIndexPath: indexPath) { [weak self] (image) in
            self?.uiDelegate?.mainMediatorUIDelegateDidSelectImage(image)
        }
    }
    
}