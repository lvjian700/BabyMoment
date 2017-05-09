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
    func didSelectPhotos(_ selectedAsset: [PHAsset])
}

class XLPhotoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var fetchResult: PHFetchResult<AnyObject>!
    var asset: [PHAsset] = []
    var selectedIndex = Set<Int>()
    var selectedAsset = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cachingImageManager = PHCachingImageManager()
        
        fetchResult.enumerateObjects({ (object, _, _) in
            if let asset = object as? PHAsset {
                self.asset.append(asset)
            }
        })
        
        cachingImageManager.startCachingImages(for: asset,
            targetSize: PHImageManagerMaximumSize,
            contentMode: .aspectFit,
            options: nil
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if fetchResult.count > 0 {
            let contentSize = collectionView.contentSize
            let point: CGPoint = CGPoint(x: 0, y: contentSize.height - UIScreen.main.bounds.height + 64)
            let rect: CGRect = CGRect(origin: point, size: UIScreen.main.bounds.size)
            collectionView.scrollRectToVisible(rect, animated: false)
        }
    }
    
    @IBAction func doneAction(_ sender: AnyObject) {
        navigationController?.dismiss(animated: true, completion: nil)
        (navigationController as! XLNavigationViewController).photoDelegate?.didSelectPhotos(selectedAsset)
    }
}

extension XLPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XLPhotoCell", for: indexPath) as! XLPhotoCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let photoCell = cell as? XLPhotoCell else { return }
        photoCell.configCell(asset[indexPath.row])
        if selectedIndex.contains(indexPath.row) {
            photoCell.selectImageView.image = UIImage(named: "Selected")
        } else {
            photoCell.selectImageView.image = UIImage(named: "Select")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "XLPhotoFooterIdentifier", for: indexPath) as! XLPhotoFooterView
        footer.numberOfPhotoLabel.text = "\(fetchResult.count) Photos"
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! XLPhotoCell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellLength = (width - 10) / 2
        return CGSize(width: cellLength, height: cellLength * 0.618)
    }
    
    fileprivate func removeSelectedPhotoByIndexPath(_ indexPath: IndexPath) {
        for (index ,item) in selectedAsset.enumerated() {
            if item == asset[indexPath.row] {
                selectedAsset.remove(at: index)
                break
            }
        }
    }
    
    fileprivate func isSelectedAssetContainPHAsset(_ asset: PHAsset) -> Bool {
        for item in selectedAsset {
            if item == asset {
                return true
            }
        }
        return false
    }
}
