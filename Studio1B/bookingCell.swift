//
//  TableViewCell.swift
//  Studio1B
//
//  Created by Sam Zammit on 7/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class bookingCell: UITableViewCell {
    
    @IBOutlet weak var bookingID: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var noOfGuests: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Test")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
