//
//  DiscountCell.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 25/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class DiscountCell: UITableViewCell {

    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var discountName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
