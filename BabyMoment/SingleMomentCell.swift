//
//  MomentCell.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/24/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class SingleMomentCell: UITableViewCell {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var yearMonth: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
