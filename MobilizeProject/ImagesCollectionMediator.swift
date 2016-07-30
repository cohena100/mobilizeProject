//
//  ImagesCollectionMediator.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

protocol ImagesCollectionMediatorUIDelegate: class {
    func refresh()
}

protocol ImagesCollectionMediatorDelegate: class {
    
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
        imagesCommands.setup({ 
            self.uiDelegate?.refresh()
            }) { (error) in
        }
    }
    
    func numberOfSectionsInCollectionView() -> Int {
        return 1
    }
    
    func collectionView(numberOfItemsInSection section: Int) -> Int {
        return imagesCommands.images.count
    }
    
    func imageItemForItemAtIndexPath(indexPath: NSIndexPath) -> Image {
        return imagesCommands.images[indexPath.row]
    }
    
    func cache(thumbnail: UIImage, atIndexPath indexPath: NSIndexPath) {
        imagesCommands.cache(thumbnail, atIndexPath: indexPath)
    }
    
}