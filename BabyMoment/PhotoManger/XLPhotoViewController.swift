//
//  XLPhotoViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit
import Photos

protocol XLPhotoDelegate: class {
    func didSelectPhotos(selectedAsset: [PHAsset])
}

class XLPhotoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var fetchResult: PHFetchResult!
    var asset: [PHAsset] = []
    var selectedIndex = Set<Int>()
    var selectedAsset = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cachingImageManager = PHCachingImageManager()
        fetchResult.enumerateObjectsUsingBlock { (object, _, _) in
            if let asset = object as? PHAsset {
                self.asset.append(asset)
            }
        }
        cachingImageManager.startCachingImagesForAssets(asset,
            targetSize: PHImageManagerMaximumSize,
            contentMode: .AspectFit,
            options: nil
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if fetchResult.count > 0 {
            let contentSize = collectionView.contentSize
            let point: CGPoint = CGPoint(x: 0, y: contentSize.height - UIScreen.mainScreen().bounds.height + 64)
            let rect: CGRect = CGRect(origin: point, size: UIScreen.mainScreen().bounds.size)
            collectionView.scrollRectToVisible(rect, animated: false)
        }
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        (navigationController as! XLNavigationViewController).photoDelegate?.didSelectPhotos(selectedAsset)
    }
}

extension XLPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("XLPhotoCell", forIndexPath: indexPath) as! XLPhotoCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let photoCell = cell as? XLPhotoCell else { return }
        photoCell.configCell(asset[indexPath.row])
        if selectedIndex.contains(indexPath.row) {
            photoCell.selectImageView.image = UIImage(named: "Selected")
        } else {
            photoCell.selectImageView.image = UIImage(named: "Select")
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "XLPhotoFooterIdentifier", forIndexPath: indexPath) as! XLPhotoFooterView
        footer.numberOfPhotoLabel.text = "\(fetchResult.count) Photos"
        return footer
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! XLPhotoCell
        if isSelectedAssetContainPHAsset(asset[indexPath.row]) {
            removeSelectedPhotoByIndexPath(indexPath)
            cell.selectImageView.image = UIImage(named: "Select")
            selectedIndex.remove(indexPath.row)
        } else {
            selectedAsset.append(asset[indexPath.row])
            cell.selectImageView.image = UIImage(named: "Selected")
            selectedIndex.insert(indexPath.row)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellLength = (width - 10) / 2
        return CGSize(width: cellLength, height: cellLength * 0.618)
    }
    
    private func removeSelectedPhotoByIndexPath(indexPath: NSIndexPath) {
        for (index ,item) in selectedAsset.enumerate() {
            if item == asset[indexPath.row] {
                selectedAsset.removeAtIndex(index)
                break
            }
        }
    }
    
    private func isSelectedAssetContainPHAsset(asset: PHAsset) -> Bool {
        for item in selectedAsset {
            if item == asset {
                return true
            }
        }
        return false
    }
}
