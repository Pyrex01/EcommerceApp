//
//  ProfileController.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 30/04/23.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        let userNameRaw = UserDefaults.standard.object(forKey: "username")
        if userNameRaw != nil {
            username.text = (userNameRaw as! String)
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "isLoged")
        UserDefaults.standard.removeObject(forKey: "username")
        
        let loginViewController = LoginViewViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
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
