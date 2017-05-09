import UIKit

class ChooseBirthdayViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        header.layer.shadowOffset = CGSize(width: 0, height: 1)
        header.layer.shadowRadius = 1
        header.layer.shadowOpacity = 0.1
    }
    
    @IBAction func chooseDate(_ sender: AnyObject) {
        setBirthday(datePicker.date)
        showNextPage()
    }
    
    fileprivate func showNextPage() {
        let inputNameVC =
            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputNameViewController") as! InputNameViewController
        navigationController?.pushViewController(inputNameVC, animated: true)
    }
    
    fileprivate func setBirthday(_ date: Date) {
        BabyProfile.saveBirthday(datePicker.date)
    }
}
