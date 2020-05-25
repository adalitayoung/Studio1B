//
//  OrderListCell.swift
//  Studio1B
//
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var TimeToServe: UILabel!
    @IBOutlet weak var orderStatus: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
