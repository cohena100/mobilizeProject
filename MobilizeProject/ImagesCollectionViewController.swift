//
//  ImagesCollectionViewController.swift
//  MobilizeProject
//
//  Created by Avi Cohen on 29/7/16.
//  Copyright © 2016 Avi Cohen. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UICollectionViewController {

    var mediator: ImagesCollectionMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = (self.navigationController as! MainNavigationController).mediator
        self.mediator = ImagesCollectionMediator(uiDelegate: self, delegate: delegate)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mediator.setup()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return mediator.numberOfSectionsInCollectionView()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediator.collectionView(numberOfItemsInSection: section)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let imageItem = mediator.imageItemForItemAtIndexPath(indexPath)
        if let thumbnail = imageItem.thumbnail {
            cell.imageImageView.image = thumbnail
            return cell
        }
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let imageData = NSData(contentsOfURL: imageItem.imageThumb)!
            let thumbnail = UIImage(data:imageData)!
            self.mediator.cache(thumbnail, atIndexPath: indexPath)
            dispatch_async(dispatch_get_main_queue()) {
                cell.imageImageView.image = thumbnail
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension ImagesCollectionViewController: ImagesCollectionMediatorUIDelegate {
    
    func refresh() {
        self.collectionView?.reloadData()
    }
    
}
