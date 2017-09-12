//
//  MeViewController.swift
//  Taskiller
//
//  Created by kingcyk on 12/09/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import TaskillerKit

class MeViewController: UIViewController {

    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var nickyName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    let icons = [
        "achievement",
        "taskdata"
    ]
    
    let names = [
        "Achievement",
        "Task data"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundAvatar(avatar: avatar)
        profileTable.rowHeight = 50
        profileTable.separatorStyle = .none
        profileTable.dataSource = self
        profileTable.delegate = self
        profileTable.isScrollEnabled = false
        profileTable.register(UINib(nibName: "NewTaskTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProfile(_ sender: Any) {
        
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


// MARK: - UITableView
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewTaskTableViewCell
        cell.nameLabel.text = names[indexPath.row]
        cell.categoryImage.image = UIImage(named: icons[indexPath.row])
        cell.valueLabel.isEnabled = false
        cell.valueLabel.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTable.deselectRow(at: indexPath, animated: true)
    }
}
