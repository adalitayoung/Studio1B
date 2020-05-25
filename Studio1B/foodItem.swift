//
//  foodItem.swift
//  Studio1B
//
//  Created by Sam Zammit on 5/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import Foundation

 class Item {
    var itemName: String
    var itemDescription: String
    var dinnerPrice: Int
    var lunchPrice: Int
    var itemID: String
    var itemType: String

    init(itemName: String, itemDescription: String, dinnerPrice: Int, lunchPrice: Int, itemID: String, itemType: String) {
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.dinnerPrice = dinnerPrice
        self.lunchPrice = lunchPrice
        self.itemID = itemID
        self.itemType = itemType
    }
}
