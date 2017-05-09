import UIKit
import Photos
import DateToolsSwift
import RealmSwift

class SingleMomentCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var yearMonth: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var textField: UITextField!

    var viewModel: MomentViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldShouldReturn(textField)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let message = textField.text {
            self.viewModel.message = message
        }

        textField.resignFirstResponder()
        return true
    }
    
    func configureCell(_ cellViewModel: MomentViewModel) {
        self.viewModel      = cellViewModel
        self.textField.text = viewModel.message
        self.time.text      = viewModel.photoTakenDesc
        self.timeAgo.text   = viewModel.uploadedAtDesc
        
        setImageFromLocal(self.heroImage, assetLocationId: cellViewModel.assetLocationId)
        self.viewModel.messageDidChange = { [weak self] viewModel in
            self?.textField.text = viewModel.message
        }
    }
    
    func setImageFromLocal(_ imageView: UIImageView, assetLocationId: String) {
        let result: PHFetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetLocationId], options: nil)
        guard let firstResult = result.firstObject else { return }
        
        let asset:PHAsset = firstResult 
        
        let request = PHImageRequestOptions()
        request.resizeMode = .exact
        request.deliveryMode = .highQualityFormat
        let manager = PHImageManager.default()
        let scale = UIScreen.main.scale
        let width = UIScreen.main.bounds.width
        let targetSize = CGSize(width: width * scale, height: width * 0.618 * scale)
        manager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFill, options: request) { (image, _) -> Void in
            imageView.image = image
        }
    }
}
