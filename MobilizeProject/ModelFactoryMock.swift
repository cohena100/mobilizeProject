//
//  ModelFactoryMock.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 04/08/2016.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import Foundation

class ModelFactoryMock: IModelFactory {
    
    let imagesModel = ImagesModel(network: NetworkMock())
    
    func getImagesCommands() -> ImagesCommands {
        return ImagesCommands(imagesModel: imagesModel)
    }
    
}