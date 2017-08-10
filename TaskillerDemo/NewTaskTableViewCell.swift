//
//  NewTaskTableViewCell.swift
//  TaskillerDemo
//
//  Created by kingcyk on 02/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit

class NewTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
