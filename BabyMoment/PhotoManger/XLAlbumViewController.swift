//
//  XLAlbumViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/24/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit
import Photos

class XLNavigationViewController: UINavigationController {
    weak var photoDelegate: XLPhotoDelegate?
}

class XLAlbumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var albumItems = [XLAlbumItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 107
        tableView.tableFooterView = UIView()
        
        configAlbumTableView()
        directJumpToPhotoPage()
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func configAlbumTableView() {
        let smartAlbums = getSystemPhotoPHFetchResult()
        savePHCollectionByFetchResult(smartAlbums)
        
        let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
        savePHCollectionByFetchResult(topLevelUserCollections)
    }
    
    private func getSystemPhotoPHFetchResult() -> [PHFetchResult] {
        var fetchResults = [PHFetchResult]()
        fetchResults.append(PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil))
        fetchResults.append(PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumRecentlyAdded, options: nil))
        fetchResults.append(PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumFavorites, options: nil))
        fetchResults.append(PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumPanoramas, options: nil))
        return fetchResults
    }
    
    private func savePHCollectionByFetchResult(fetchResults: [PHFetchResult]) {
        for fetchResult in fetchResults {
            for index in 0..<fetchResult.count {
                if let assetCollection = fetchResult.objectAtIndex(index) as? PHAssetCollection {
                    albumItems.append(XLAlbumItem(albumTitle: assetCollection.localizedTitle!, assetCollection: assetCollection))
                }
            }
        }
    }
    
    private func savePHCollectionByFetchResult(fetchResult: PHFetchResult) {
        for index in 0 ..< fetchResult.count {
            if let collection = fetchResult.objectAtIndex(index) as? PHAssetCollection {
                albumItems.append(XLAlbumItem(albumTitle: collection.localizedTitle!, assetCollection: collection))
            }
        }
    }
    
    private func directJumpToPhotoPage() {
        let photoViewController = getPhotoViewControllerByFetchResult(getFetchResultByPHAssetCollection(albumItems[0].assetCollection))
        self.navigationController?.pushViewController(photoViewController, animated: false)
    }
    
    private func getPhotoViewControllerByFetchResult(fetchResult: PHFetchResult) -> XLPhotoViewController {
        let photoViewController = UIStoryboard.init(name: "XLPhotoManager", bundle: nil).instantiateViewControllerWithIdentifier("XLPhotoViewController") as! XLPhotoViewController
        photoViewController.fetchResult = fetchResult
        return photoViewController
    }
    
    private func getFetchResultByPHAssetCollection(assetCollection: PHAssetCollection) -> PHFetchResult {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        return PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
    }
}

extension XLAlbumViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as! XLAlbumCell
        cell.configCell(albumItems[indexPath.row].albumTitle, assetCollection: albumItems[indexPath.row].assetCollection)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let photoViewController = getPhotoViewControllerByFetchResult(getFetchResultByPHAssetCollection(albumItems[indexPath.row].assetCollection))
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}