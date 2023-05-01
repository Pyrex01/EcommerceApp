//
//  ViewController.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class LoginViewViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var loginViewModel = LoginViewModel()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.context = self.context
        loginViewModel.loadDataIfDoesNotExist()
        
    }
    
    

    @IBAction func signUp(_ sender: Any) {
        present(SignUpController(),animated: true,completion: nil)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        print("login started")
        let status = loginViewModel.checkLoginUser(username: username.text!, password: password.text!)
        print(status)
        switch(status){
        case .sucess:
            let defaults = UserDefaults.standard
            defaults.set(true,forKey: "isLoged")
            defaults.set(username.text,forKey: "username")
            let tabBarControler = MainTabBarController()
            tabBarControler.modalPresentationStyle = .fullScreen
            present(tabBarControler, animated: true, completion: nil)
            break
        
                                   
        case.empty:
            let alert = UIAlertController(title: "Alert", message: "please enter credentials", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
                                   
        case .wrong:
            let alert = UIAlertController(title: "Error", message: "wrong credentials", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
                                   
        case .failed:
            let alert = UIAlertController(title: "Error", message: "something went wrong", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
                                   
        }
        
    }
    
}

