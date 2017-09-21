//
//  MenuViewController.swift
//  TaskillerDemo
//
//  Created by kingcyk on 22/08/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import TaskillerKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundAvatar(avatar: avatar)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        
        let avatarTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProfile))
        avatarTapRecognizer.numberOfTapsRequired = 1
        avatarTapRecognizer.delegate = self
        avatar.addGestureRecognizer(avatarTapRecognizer)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tapHandler(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    func showProfile(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileView = sb.instantiateViewController(withIdentifier: "ProfileView")
        profileView.modalTransitionStyle = .flipHorizontal
        profileView.modalPresentationStyle = .fullScreen
        self.present(profileView, animated: true, completion: nil)
    }

}

extension MenuViewController: UIGestureRecognizerDelegate {
    
}
