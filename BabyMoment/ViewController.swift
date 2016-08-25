//
//  ViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/24/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cellModels: [MomentCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 314
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func selectPhoto(sender: AnyObject) {
        PHPhotoLibrary.requestAuthorization { [weak self] status -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if (status == PHAuthorizationStatus.Authorized) {
                    let picker = UIStoryboard.init(name: "XLPhotoManager", bundle: nil).instantiateViewControllerWithIdentifier("XLPhotoNavigator") as! XLNavigationViewController
                    picker.photoDelegate = self
                    self?.presentViewController(picker, animated: true, completion: nil)
                } else {
                    print("NoPhotoAuthorization")
                }
            })
        }
    }
    
}

extension ViewController: UITableViewDataSource {
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if cellModels[indexPath.row].asset.count > 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DoubleMomentCell", forIndexPath: indexPath) as! DoubleMomentCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SinglePhotoCell", forIndexPath: indexPath) as! SingleMomentCell
            return cell
        }
    }
}

extension ViewController: XLPhotoDelegate {
    func didSelectPhotos(selectedAsset: [PHAsset]) {
        print(selectedAsset.count)
        let cellModel = MomentCellModel(asset: selectedAsset)
        cellModels.append(cellModel)
    }
}

