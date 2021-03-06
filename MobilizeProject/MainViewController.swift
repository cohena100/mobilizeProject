//
//  MainViewController.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var attachedImageImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainStackViewTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainStackView: UIStackView!
    
    var mediator: MainMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainNavigationMediator = (self.navigationController as! MainNavigationController).mediator
        self.mediator = MainMediator(uiDelegate: self, delegate: mainNavigationMediator)
        mainNavigationMediator.mainMediator = self.mediator
        attachedImageImageView.hidden = true
        messageTextView.becomeFirstResponder()
        dispatch_async(dispatch_get_main_queue()) { 
            self.mainScrollView.setContentOffset(CGPointZero, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonDidTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func boldButtonDidTap(sender: AnyObject) {
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        if attachedImageImageView.hidden {
            return
        }
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardSize = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height + 16, 0)
        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
        let bottomOffset = CGPoint(x: 0, y: mainScrollView.contentSize.height - mainScrollView.bounds.size.height + mainScrollView.contentInset.bottom)
        mainScrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        mainScrollView.contentInset = UIEdgeInsetsZero
        mainScrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
}

extension MainViewController: MainMediatorUIDelegate {
    
    func mainMediatorUIDelegateDidSelectImage(image: UIImage) {
        self.attachedImageImageView.image = image
        self.attachedImageImageView.hidden = false
        dispatch_async(dispatch_get_main_queue()) {
            let bottomOffset = CGPoint(x: 0, y: self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height + self.mainScrollView.contentInset.bottom)
            self.mainScrollView.setContentOffset(bottomOffset, animated: true)
        }
    }

}
