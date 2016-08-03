//
//  ImagesCommands.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImagesCommands  {
    
    weak var imagesModel: ImagesModel!
    var imageItemsCount: Int {
        return imagesModel.imageItemsCount
    }
    

    init(imagesModel: ImagesModel) {
        self.imagesModel = imagesModel
    }
    
    func setup(complete: () -> ()) {
        imagesModel.setup {
            complete()
        }
    }
 
    func thumbnail(atIndexPath indexPath: NSIndexPath, request: Int, complete: UIImageOptionalVoid) {
        return imagesModel.thumbnail(atIndexPath: indexPath, request: request, complete: complete)
    }
    
    func image(atIndexPath indexPath: NSIndexPath, complete: (image: UIImage) -> ()) {
        return imagesModel.image(atIndexPath: indexPath, complete: complete)
    }
    
}