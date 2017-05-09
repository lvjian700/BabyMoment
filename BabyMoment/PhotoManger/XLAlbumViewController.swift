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
    
    fileprivate var albumItems = [XLAlbumItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 107
        tableView.tableFooterView = UIView()
        
        configAlbumTableView()
        directJumpToPhotoPage()
    }
    
    @IBAction func cancelAction(_ sender: AnyObject) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func configAlbumTableView() {
        let smartAlbums = getSystemPhotoPHFetchResult()
        savePHCollectionByFetchResult(smartAlbums)
        
        let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        savePHCollectionByFetchResult([topLevelUserCollections])
    }
    
    fileprivate func getSystemPhotoPHFetchResult() -> [PHFetchResult<PHCollection>] {
        var fetchResults = [PHFetchResult<PHCollection>]()
        fetchResults.append(PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil) as! PHFetchResult<PHCollection>)
        fetchResults.append(PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumRecentlyAdded, options: nil) as! PHFetchResult<PHCollection>)
        fetchResults.append(PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil) as! PHFetchResult<PHCollection>)
        fetchResults.append(PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumPanoramas, options: nil) as! PHFetchResult<PHCollection>)
        return fetchResults
    }
    
    fileprivate func savePHCollectionByFetchResult(_ fetchResults: [PHFetchResult<PHCollection>]) {
        for fetchResult in fetchResults {
            for index in 0..<fetchResult.count {
                if let assetCollection = fetchResult.object(at: index) as? PHAssetCollection {
                    albumItems.append(XLAlbumItem(albumTitle: assetCollection.localizedTitle!, assetCollection: assetCollection))
                }
            }
        }
    }
    
    fileprivate func savePHCollectionByFetchResult(_ fetchResult: PHFetchResult<AnyObject>) {
        for index in 0 ..< fetchResult.count {
            if let collection = fetchResult.object(at: index) as? PHAssetCollection {
                albumItems.append(XLAlbumItem(albumTitle: collection.localizedTitle!, assetCollection: collection))
            }
        }
    }
    
    fileprivate func directJumpToPhotoPage() {
        let photoViewController = getPhotoViewControllerByFetchResult(getFetchResultByPHAssetCollection(albumItems[0].assetCollection))
        self.navigationController?.pushViewController(photoViewController, animated: false)
    }
    
    fileprivate func getPhotoViewControllerByFetchResult(_ fetchResult: PHFetchResult<AnyObject>) -> XLPhotoViewController {
        let photoViewController = UIStoryboard.init(name: "XLPhotoManager", bundle: nil).instantiateViewController(withIdentifier: "XLPhotoViewController") as! XLPhotoViewController
        photoViewController.fetchResult = fetchResult
        return photoViewController
    }
    
    fileprivate func getFetchResultByPHAssetCollection(_ assetCollection: PHAssetCollection) -> PHFetchResult<AnyObject> {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        return PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
    }
}

extension XLAlbumViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! XLAlbumCell
        cell.configCell(albumItems[indexPath.row].albumTitle, assetCollection: albumItems[indexPath.row].assetCollection)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoViewController = getPhotoViewControllerByFetchResult(getFetchResultByPHAssetCollection(albumItems[indexPath.row].assetCollection))
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}
