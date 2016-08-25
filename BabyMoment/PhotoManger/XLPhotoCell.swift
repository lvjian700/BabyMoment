//
//  XLPhotoCell.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit
import Photos

class XLPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
}

extension XLPhotoCell {
    func configCell(asset: PHAsset) {
        let request = PHImageRequestOptions()
        request.deliveryMode = .Opportunistic
        
        let scale = UIScreen.mainScreen().scale
        let targetSize = CGSize(width: 70 * scale, height: 70 * scale)
        
        let manager = PHImageManager.defaultManager()
        
        if tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(tag))
        }
        
        tag = Int(manager.requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: request) { (image, _) -> Void in
            self.photoImageView.image = image
            })
    }
}
