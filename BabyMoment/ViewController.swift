//
//  ViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/24/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit
import Photos
import HEXColor
import DateTools

class TabBarVC: UITabBarController {}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cellModels: [MomentCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor(rgba: "#F6DC6E")
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
        var cellModel = cellModels[indexPath.row]
        if cellModel.asset.count > 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DoubleMomentCell", forIndexPath: indexPath) as! DoubleMomentCell
            cell.setImageFromLocal(cell.heroImage, asset: cellModel.asset[0])
            cell.setImageFromLocal(cell.secondImage, asset: cellModel.asset[1])
            cell.setDate(cellModel.photoTakenDate!)
            cell.setUploadedAt(cellModel.currentDate!)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SinglePhotoCell", forIndexPath: indexPath) as! SingleMomentCell
            cell.setImageFromLocal(cell.heroImage, asset: cellModel.asset[0])
            cell.setUploadedAt(cellModel.currentDate!)
            cell.setDate(cellModel.photoTakenDate!)//set cal date
            return cell
        }
    }
}

extension ViewController: XLPhotoDelegate {
    func didSelectPhotos(selectedAsset: [PHAsset]) {
        if selectedAsset.count > 0 {
            var cellModel = MomentCellModel(asset: selectedAsset)
            let asset = selectedAsset[0]
            if let createDate = asset.creationDate {
                cellModel.photoTakenDate = createDate
            }
            cellModels.append(cellModel)
            tableView.reloadData()
        }
    }
}

