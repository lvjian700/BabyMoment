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
    func configCell(_ albumTitle: String, assetCollection: PHAssetCollection) {
        albumNameLabel.text = albumTitle
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        
        let fetchResult = PHAsset.fetchAssets(in: assetCollection, options: options)
        albumPhotoCountLabel.text = "\(fetchResult.count) photos"
        
        let request = PHImageRequestOptions()
        request.deliveryMode = .opportunistic
        request.resizeMode = .exact
        
        let scale = UIScreen.main.scale
        let targetSize = CGSize(width: 70 * scale, height: 70 * scale)
        
        let manager = PHImageManager.default()
        
        if tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(tag))
        }
        
        if fetchResult.count > 0 {
            tag = Int(manager.requestImage(for: fetchResult.firstObject! as PHAsset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFill, options: request) { (image, _) -> Void in
                self.albumCoverImageView.image = image
                })
        } else {
            self.albumCoverImageView.image = UIImage(named: "DefaultCoverImage")
        }
    }
}
