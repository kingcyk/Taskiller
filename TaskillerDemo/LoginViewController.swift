//
//  LoginViewController.swift
//  Taskiller
//
//  Created by kingcyk on 11/09/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import RealmSwift
import TaskillerKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    let serverURL = "http://taskiller.kingcyk.com:9080"
    
    private let accountManager = AccountManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login(_ sender: UIButton) {
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password, register: false)
        SyncUser.logIn(with: usernameCredentials, server: URL(string: serverURL)!) { (user, error) in
            if let user = user {
                
            } else if let error = error {
                print("Login error: \(error.localizedDescription)")
            }
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
