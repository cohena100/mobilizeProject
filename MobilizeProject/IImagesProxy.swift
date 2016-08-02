//
//  IImagesProxy.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 30/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

protocol IImagesProxy: class {
    
    var imageItemsCount: Int { get }
    
    func setup(complete: () -> ())
    func thumbnail(atIndexPath indexPath: NSIndexPath, complete: (thumbnail: UIImage) -> ())
    func image(atIndexPath indexPath: NSIndexPath, complete: (image: UIImage) -> ())
    
}