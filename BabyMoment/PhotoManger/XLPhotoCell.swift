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
    func configCell(_ asset: PHAsset) {
        let request = PHImageRequestOptions()
        request.deliveryMode = .opportunistic
        
        let scale = UIScreen.main.scale
        let targetSize = CGSize(width: 70 * scale, height: 70 * scale)
        
        let manager = PHImageManager.default()
        
        if tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(tag))
        }
        
        tag = Int(manager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFill, options: request) { (image, _) -> Void in
            self.photoImageView.image = image
            })
    }
}
