//
//  SignUpController.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//

import UIKit

class SignUpController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let signUpViewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpViewModel.context = self.context
        // Do any additional setup after loading the view.
    }


    @IBAction func signUp(_ sender: Any) {
        let status = signUpViewModel.signUp(username: username.text!, password: password.text!)
        
        switch(status){
        case .empty:
            let alert = UIAlertController(title: "Alert", message: "please enter credentials", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .sucess:
            let alert = UIAlertController(title: "Alert", message: "user added sucessfuly", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert,animated: true)
            username.text = ""
            password.text = ""
            break
        case.exist:
            let alert = UIAlertController(title: "Alert", message: "username exist", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .failed:
            let alert = UIAlertController(title: "Alert", message: "something went wrong", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
