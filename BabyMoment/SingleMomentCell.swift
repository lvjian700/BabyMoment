import UIKit
import Photos
import DateTools
import RealmSwift

class SingleMomentCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var yearMonth: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var textField: UITextField!
    var model: Moment!
    
    func saveAction(content: String) {
        let realm = try! Realm()
        try! realm.write {
            model.text = content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textFieldShouldReturn(textField)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let text = textField.text {
            saveAction(text)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func setMoment(moment: Moment) {
        self.model = moment
        textField.text = model.text
        setDate(model.photoTakenDate)
        setUploadedAt(model.uploadedAt)
    }
    
    private func setDate(date: NSDate) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd"
        day.text = formatter.stringFromDate(date)
        
        formatter.dateFormat = "yyyy.MM"
        yearMonth.text = formatter.stringFromDate(date)
        
        let oldText:String = date.howOld((BabyProfile.currentProfile()?.birthday)!)
        time.text = oldText;
    }
    
    private func setUploadedAt(date: NSDate) {
        let timeAgoText:String = date.timeAgoSinceNow()
        timeAgo.text = timeAgoText
    }
}

extension UITableViewCell {
    func setImageFromLocal(imageView: UIImageView, assetLocationId: String) {
        let result: PHFetchResult = PHAsset.fetchAssetsWithLocalIdentifiers([assetLocationId], options: nil)
        let asset:PHAsset = result.firstObject as! PHAsset
        
        let request = PHImageRequestOptions()
        request.resizeMode = .Exact
        request.deliveryMode = .HighQualityFormat
        let manager = PHImageManager.defaultManager()
        let scale = UIScreen.mainScreen().scale
        let width = UIScreen.mainScreen().bounds.width
        let targetSize = CGSize(width: width * scale, height: width * 0.618 * scale)
        manager.requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: request) { (image, _) -> Void in
            imageView.image = image
        }
    }
}
