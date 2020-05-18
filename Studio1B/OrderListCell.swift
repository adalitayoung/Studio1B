//
//  OrderListCell.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 18/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {

    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var foodQty: UILabel!
    @IBOutlet weak var drinksQty: UILabel!
    @IBOutlet weak var timeToServe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
