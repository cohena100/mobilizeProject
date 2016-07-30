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
    
    deinit {
        print("ImagesCollectionViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainNavigationMediator = (self.navigationController as! MainNavigationController).mediator
        self.mediator = ImagesCollectionMediator(uiDelegate: self, delegate: mainNavigationMediator)
        mainNavigationMediator.imagesCollectionMediator = self.mediator
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
        dispatch_async(dispatch_get_global_queue(priority, 0)) { [weak self] in
            let imageData = NSData(contentsOfURL: imageItem.imageThumb)!
            let thumbnail = UIImage(data:imageData)!
            dispatch_async(dispatch_get_main_queue()) {
                guard let myself = self else {
                    return
                }
                myself.mediator.cache(thumbnail, atIndexPath: indexPath)
                cell.imageImageView.image = thumbnail
            }
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        mediator.collectionView(didSelectItemAtIndexPath: indexPath)
    }

}

extension ImagesCollectionViewController: ImagesCollectionMediatorUIDelegate {
    
    func imagesCollectionMediatorUIDelegateRefresh() {
        self.collectionView?.reloadData()
    }
    
}
