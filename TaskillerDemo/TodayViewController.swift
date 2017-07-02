//
//  TodayViewController.swift
//  TaskillerDemo
//
//  Created by kingcyk on 02/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!

    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarView.layer.cornerRadius = self.avatarView.frame.size.width / 2
        self.avatarView.layer.masksToBounds = true
        
        self.dateFormatter.locale = Locale.current
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        self.dateLabel.text = dateFormatter.string(from: Date()).uppercased()
        
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

}
