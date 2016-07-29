//
//  MainViewController.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var messageTextViewHeightLayoutConstraint: NSLayoutConstraint!
    
    var mediator: MainMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = (self.navigationController as! MainNavigationController).mediator
        self.mediator = MainMediator(uiDelegate: self, delegate: delegate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonDidTap(sender: AnyObject) {
        self.view.endEditing(true)
    }

    @IBAction func imageButtonDidTap(sender: AnyObject) {
    }
    
    @IBAction func boldButtonDidTap(sender: AnyObject) {
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
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
    
}
