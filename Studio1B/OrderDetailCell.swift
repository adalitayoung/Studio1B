//
//  OrderDetailCell.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 19/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
