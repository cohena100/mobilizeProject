//
//  ImagesCollectionMediator.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

protocol ImagesCollectionMediatorUIDelegate: class {
    func imagesCollectionMediatorUIDelegateRefresh()
}

protocol ImagesCollectionMediatorDelegate: class {
    func imagesCollectionMediatorDelegateDidSelectImage(atIndexPath indexPath: NSIndexPath)
}

class ImagesCollectionMediator {
    
    weak var uiDelegate: ImagesCollectionMediatorUIDelegate?
    weak var delegate: ImagesCollectionMediatorDelegate?
    let imagesCommands: ImagesCommands
    
    init(uiDelegate: ImagesCollectionMediatorUIDelegate, delegate: ImagesCollectionMediatorDelegate) {
        self.uiDelegate = uiDelegate
        self.delegate = delegate
        self.imagesCommands = Model.sharedInstance.factory.getImagesCommands()
    }
    
    func setup() {
        imagesCommands.setup { 
            self.uiDelegate?.imagesCollectionMediatorUIDelegateRefresh()
        }
    }
    
    func numberOfSectionsInCollectionView() -> Int {
        return 1
    }
    
    func collectionView(numberOfItemsInSection section: Int) -> Int {
        return imagesCommands.imageItemsCount
    }
    
    func thumbnail(atIndexPath indexPath: NSIndexPath, complete: (thumbnail: UIImage) -> ()) {
        return imagesCommands.thumbnail(atIndexPath: indexPath, complete: complete)
    }
    
    func collectionView(didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.imagesCollectionMediatorDelegateDidSelectImage(atIndexPath: indexPath)
    }
    
}