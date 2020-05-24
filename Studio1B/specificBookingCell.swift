//
//  specificBookingCell.swift
//  Studio1B
//
//  Created by Sam Zammit on 21/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class specificBookingCell: UITableViewCell {
    
    @IBOutlet weak var firstNameEdit: UILabel!
    @IBOutlet weak var lastNameEdit: UILabel!
    @IBOutlet weak var emailEdit: UILabel!
    @IBOutlet weak var numberEdit: UILabel!
    @IBOutlet weak var timeEdit: UILabel!
    @IBOutlet weak var guestsEdit: UILabel!
    @IBOutlet weak var messageEdit: UILabel!
    @IBOutlet weak var customerIDEdit: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
