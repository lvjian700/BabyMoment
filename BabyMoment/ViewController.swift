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

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = Moment.all()
    
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
        return models.count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SinglePhotoCell", forIndexPath: indexPath) as! SingleMomentCell
        
        let model = models[indexPath.row]
        cell.setImageFromLocal(cell.heroImage, assetLocationId: model.assetLocationId)
        cell.setUploadedAt(model.uploadedAt)
        cell.setDate(model.photoTakenDate)
        
        return cell
    }
}

extension ViewController: XLPhotoDelegate {
    func didSelectPhotos(selectedAsset: [PHAsset]) {
        if selectedAsset.count == 0 {
            return
        }
        let asset = selectedAsset[0]
        
        let locationId: String = asset.localIdentifier
        let moment = Moment(value: ["assetLocationId": locationId])
        
        if let photoDate = asset.creationDate {
            moment.photoTakenDate = photoDate
        }
        
        moment.save()
        models = Moment.all()
        tableView.reloadData()
    }
}

