//
//  ImagesCommands.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImagesCommands  {
    
    weak var imagesProxy: IImagesProxy!
    var imageItemsCount: Int {
        return imagesProxy.imageItemsCount
    }
    

    init(imagesProxy: IImagesProxy) {
        self.imagesProxy = imagesProxy
    }
    
    func setup(complete: () -> ()) {
        imagesProxy.setup { 
            complete()
        }
    }
 
    func thumbnail(atIndexPath indexPath: NSIndexPath, complete: (thumbnail: UIImage) -> ()) {
        return imagesProxy.thumbnail(atIndexPath: indexPath, complete: complete)
    }
    
    func image(atIndexPath indexPath: NSIndexPath, complete: (image: UIImage) -> ()) {
        return imagesProxy.image(atIndexPath: indexPath, complete: complete)
    }
    
}