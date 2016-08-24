//
//  XLAlbumCell.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/24/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit
import Photos

class XLAlbumCell: UITableViewCell {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumPhotoCountLabel: UILabel!
    @IBOutlet weak var albumCoverImageView: UIImageView!
}

extension XLAlbumCell {
    func configCell(albumTitle: String, assetCollection: PHAssetCollection) {
        albumNameLabel.text = albumTitle
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        
        let fetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: options)
        albumPhotoCountLabel.text = "\(fetchResult.count) photos"
        
        let request = PHImageRequestOptions()
        request.deliveryMode = .Opportunistic
        request.resizeMode = .Exact
        
        let scale = UIScreen.mainScreen().scale
        let targetSize = CGSize(width: 70 * scale, height: 70 * scale)
        
        let manager = PHImageManager.defaultManager()
        
        if tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(tag))
        }
        
        if fetchResult.count > 0 {
            tag = Int(manager.requestImageForAsset(fetchResult.firstObject as! PHAsset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: request) { (image, _) -> Void in
                self.albumCoverImageView.image = image
                })
        } else {
            self.albumCoverImageView.image = UIImage(named: "DefaultCoverImage")
        }
    }
}
