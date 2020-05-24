//
//  SpecificInvoiceTableCell.swift
//  Studio1B
//
//  Created by Adalita Young on 22/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class SpecificInvoiceTableCell: UITableViewCell {

    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCost: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
