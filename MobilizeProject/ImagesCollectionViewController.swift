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
    var celltag = 0
    
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
        if cell.tag == 0 {
            celltag += 1
            cell.tag = celltag
        }
        cell.imageImageView.image = nil
        mediator.thumbnail(atIndexPath: indexPath, cellTag: cell.tag) { (image) in
            if image == nil {
                return
            }
            cell.imageImageView.image = image
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
