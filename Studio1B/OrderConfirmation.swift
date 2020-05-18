//
//  OrderConfirmation.swift
//  Studio1B
//
//  Created by David Bolis on 16/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class OrderConfirmation: UITableViewCell {
    @IBOutlet weak var MealOrdered: UILabel!
    @IBOutlet weak var QTN: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
