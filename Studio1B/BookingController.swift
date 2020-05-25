//
//  bookingController.swift
//  Studio1B
//
//  Created by Sam Zammit on 28/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class BookingController: UIViewController {

let db = Firestore.firestore()

@IBAction func createNewBooking_BTN(_ sender: Any) {
    //performSegue(withIdentifier: "", sender: self)
}

@IBAction func availableTables_BTN(_ sender: Any) {
    //performSegue(withIdentifier: "createNewStaffRecordSegue", sender: self)
}

override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
}

}
