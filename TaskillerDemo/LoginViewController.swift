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
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
        
    private let accountManager = AccountManager.sharedInstance
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if groupDefaults.object(forKey: BuildKey) == nil {
            self.present(GuideViewController(), animated: false, completion: nil)
            groupDefaults.set(true, forKey: BuildKey)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTextField(_ sender: Any) {
        passwordTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    @IBAction func login(_ sender: UIButton) {
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        print("usr: \(username), pwd: \(password)")
        if !validatePassword(password: password) {
            SVProgressHUD.showError(withStatus: "Invalid Password")
            return
        }
        let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password, register: false)
        SVProgressHUD.show(withStatus: "Logging in...")
        SyncUser.logIn(with: usernameCredentials, server: URL(string: serverURL)!) { (user, error) in
            if user != nil {
                self.dismiss(animated: true, completion: nil)
                SVProgressHUD.showSuccess(withStatus: "Login success")
                self.accountManager.addAccount(username, password)
            } else if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
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
