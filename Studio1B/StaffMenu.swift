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
        performSegue(withIdentifier: "toStaffRecords", sender: self)

    }
    
    @IBAction func menuManagement_BTN(_ sender: Any) {
        performSegue(withIdentifier: "toStaffMenu", sender: self)
    }
    
    @IBAction func orderList_BTN(_ sender: Any) {
        performSegue(withIdentifier: "toOrderList", sender: self)
    }
    
    
    @IBAction func logout_BTN(_ sender: Any) {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        do {
            defer{
                performSegue(withIdentifier: "logout", sender: self)
            }
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error Signing out.")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userRole)
    }
}
