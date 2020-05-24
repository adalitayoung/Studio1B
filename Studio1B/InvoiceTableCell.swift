//
//  InvoiceTableCell.swift
//  Studio1B
//
//  Created by Adalita Young on 21/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class InvoiceTableCell: UITableViewCell {

    
    @IBOutlet weak var TimeCreated: UILabel!
    @IBOutlet weak var isPaid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
