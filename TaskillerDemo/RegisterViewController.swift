//
//  RegisterViewController.swift
//  Taskiller
//
//  Created by kingcyk on 11/09/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    let serverURL = "http://taskiller.kingcyk.com:9080"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func register(_ sender: UIButton) {
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        let confirm = confirmTextField.text!
        if password != confirm {
            // TODO: - Show error
            return
        } else {
            let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password, register: true)
            SyncUser.logIn(with: usernameCredentials, server: URL(string: serverURL)!, onCompletion: { (user, error) in
                if let user = user {
                    
                } else if let error = error {
                    print(error.localizedDescription)
                }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
