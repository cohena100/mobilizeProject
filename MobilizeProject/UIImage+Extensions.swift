//
//  UIImage+Extensions.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 04/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(from view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}