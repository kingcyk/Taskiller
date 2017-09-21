//
//  ListsViewController.swift
//  TaskillerDemo
//
//  Created by kingcyk on 02/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import TaskillerKit

class ListsViewController: UIViewController {

    @IBOutlet weak var avatarView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        roundAvatar(avatar: avatarView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProfile))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        avatarView.addGestureRecognizer(tapGestureRecognizer)        // Do any additional setup after loading the view.
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
    
    func showProfile(_ sender: UITapGestureRecognizer) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileView = sb.instantiateViewController(withIdentifier: "ProfileView")
        profileView.modalTransitionStyle = .flipHorizontal
        profileView.modalPresentationStyle = .fullScreen
        self.present(profileView, animated: true, completion: nil)
    }

}

extension ListsViewController: UIGestureRecognizerDelegate {
    
}
