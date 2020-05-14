//
//  StaffCell.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 3/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class StaffCell: UITableViewCell {
    
        @IBOutlet weak var staffFirst: UILabel!
        @IBOutlet weak var staffLast: UILabel!
        @IBOutlet weak var staffRole: UILabel!
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
    
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
    
            // Configure the view for the selected state
        }

}

