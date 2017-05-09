import UIKit
import Photos
import UIColor_Hex_Swift
import DateToolsSwift

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MomentsViewModel!
    var birthday: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor("#F6DC6E")
        
        
        birthday = BabyProfile.currentProfile()!.birthday! as Date!
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
    
    @IBAction func selectPhoto(_ sender: AnyObject) {
        PHPhotoLibrary.requestAuthorization { [weak self] status -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if (status == PHAuthorizationStatus.authorized) {
                    let picker = UIStoryboard.init(name: "XLPhotoManager", bundle: nil).instantiateViewController(withIdentifier: "XLPhotoNavigator") as! XLNavigationViewController
                    picker.photoDelegate = self
                    self?.present(picker, animated: true, completion: nil)
                } else {
                    print("NoPhotoAuthorization")
                }
            })
        }
    }
}

extension ViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel.cellViewModels?.count else { return 0 }
        return count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePhotoCell", for: indexPath)
        
        guard let momentCell = cell as? SingleMomentCell else { return UITableViewCell() }
        guard let cellViewModels = viewModel.cellViewModels else { return UITableViewCell() }

        momentCell.configureCell(cellViewModels[indexPath.row])
        
        return momentCell
    }
}

extension ViewController: XLPhotoDelegate {
    func didSelectPhotos(_ selectedAsset: [PHAsset]) {
        if selectedAsset.count == 0 {
            return
        }
        let asset = selectedAsset[0]
        
        viewModel.createMoment(asset.localIdentifier, photoTakenDate: asset.creationDate!)
    }
}

