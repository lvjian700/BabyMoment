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
    
    var viewModel: MomentsViewModel!
    var birthday: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor(rgba: "#F6DC6E")
        
        birthday = BabyProfile.currentProfile()!.birthday!
        viewModel = MomentsViewModel(MomentRepository(), birthday: birthday)
        viewModel.configureCellModels()
        viewModel.subscribeToChanged { [weak self] in
            self?.reloadData()
        }
        
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 314
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    deinit {
        viewModel.unsubscribeFromChanged()
    }
    
    func reloadData() {
        viewModel.configureCellModels()
        tableView.reloadData()
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
        guard let count = viewModel.cellViewModels?.count else { return 0 }
        return count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SinglePhotoCell", forIndexPath: indexPath)
        
        guard let momentCell = cell as? SingleMomentCell else { return UITableViewCell() }
        guard let cellViewModels = viewModel.cellViewModels else { return UITableViewCell() }

        momentCell.configureCell(cellViewModels[indexPath.row])
        
        return momentCell
    }
}

extension ViewController: XLPhotoDelegate {
    func didSelectPhotos(selectedAsset: [PHAsset]) {
        if selectedAsset.count == 0 {
            return
        }
        let asset = selectedAsset[0]
        
        viewModel.createMoment(asset.localIdentifier, photoTakenDate: asset.creationDate!)
    }
}

