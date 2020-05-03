//
//  StaffMenu.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 16/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class StaffMenu: UIViewController {
    
    let db = Firestore.firestore()
    var userRole = UserDefaults.standard.object(forKey: "userRole") as! String

    @IBAction func createNewDiscount_BTN(_ sender: Any) {
        performSegue(withIdentifier: "toDiscountsSegue", sender: self)
    }
    
    
    @IBAction func staffManagement_BTN(_ sender: Any) {
        if (userRole.contains("RestaurantManager")) {
            performSegue(withIdentifier: "toStaffRecords", sender: self)
        }
        else {
            print("You Do not have access")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userRole)
    }
}
