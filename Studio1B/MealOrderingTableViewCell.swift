//
//  MealOrderingTableViewCell.swift
//  Studio1B
//
//  Created by David Bolis on 16/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class MealOrderingTableViewCell: UITableViewCell {
    @IBOutlet weak var MenuItemsLabel: UILabel!
    @IBOutlet weak var MinusBtn: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    
    @IBOutlet weak var MealCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
