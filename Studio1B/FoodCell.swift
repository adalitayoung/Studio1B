//
//  FoodCell.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 7/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}