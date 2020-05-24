//
//  Bookings.swift
//  Studio1B
//
//  Created by Sam Zammit on 7/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import Foundation

class Bookings {
    
    var bookingID: String?
    var numberOfGuests: Int?
    var preferredTime: String?
    var customerID: String?
//    var customerFirstName: String?
//    var customerLastName: String?
    
    init(bookingID: String?, numberOfGuests: Int?, preferredTime: String, customerID: String? //customerFirstName: String?, customerLastName: String?
        ){
        self.bookingID = bookingID
        self.numberOfGuests = numberOfGuests
        self.preferredTime = preferredTime
        self.customerID = customerID
//        self.customerFirstName = customerFirstName
//        self.customerLastName = customerLastName
    }
    
}
