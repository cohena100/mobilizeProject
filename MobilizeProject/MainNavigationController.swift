//
//  MainNavigationController.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    var mediator: MainNavigationMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediator = MainNavigationMediator(uiDelegate: self)
    }

}

extension MainNavigationController: MainNavigationMediatorUIDelegate {
 
    func mainNavigationMediatorUIDelegatePop() {
        self.popViewControllerAnimated(true)
    }
    
}