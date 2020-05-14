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
    @IBOutlet weak var bookingFirst: UILabel!
    @IBOutlet weak var bookingLast: UILabel!
    @IBOutlet weak var bookingNumGuests: UILabel!
    @IBOutlet weak var bookingTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
