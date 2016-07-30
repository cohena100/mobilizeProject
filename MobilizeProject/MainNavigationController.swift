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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainNavigationController: MainNavigationMediatorUIDelegate {
 
    func mainNavigationMediatorUIDelegatePop() {
        self.popViewControllerAnimated(true)
    }
    
}