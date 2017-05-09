import UIKit

class InputNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        
        header.layer.shadowOffset = CGSize(width: 0, height: 1)
        header.layer.shadowRadius = 1
        header.layer.shadowOpacity = 0.1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveName(_ sender: AnyObject) {
        saveName(nameTextField.text!)
        showNextPage()
    }
    
    fileprivate func showNextPage() {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
    }
    
    fileprivate func saveName(_ name: String) {
        BabyProfile.saveName(name)
        BabyProfile.initWithUserDefault().save()
    }
}

extension InputNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveName(nameTextField.text!)
        showNextPage()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveName(nameTextField.text!)
        showNextPage()
    }
}
