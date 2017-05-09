import UIKit

class ChooseGenderViewController: UIViewController {

    @IBOutlet weak var header: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        header.layer.shadowOffset = CGSize(width: 0, height: 1)
        header.layer.shadowRadius = 1
        header.layer.shadowOpacity = 0.1
    }
    
    
    @IBAction func chooseGirl(_ sender: AnyObject) {
        showNextPage()
        setGender(.girl)
    }
    
    @IBAction func chooseBoy(_ sender: AnyObject) {
        showNextPage()
        setGender(.boy)
    }
    
    fileprivate func showNextPage() {
        let chooseDateVC =
            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseBirthdayViewController") as! ChooseBirthdayViewController
        navigationController?.pushViewController(chooseDateVC, animated: true)
    }
    
    fileprivate func setGender(_ gender: Gender) {
        BabyProfile.saveGender(gender)
    }
}
