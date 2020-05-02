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
    let userRole = NSUserDefaults.standardUserDefaults().objectForKey("userRole") as? [String]

    @IBAction func createNewDiscount_BTN(_ sender: Any) {
        performSegue(withIdentifier: "toDiscountsSegue", sender: self)
    }
    
    @IBAction func createNewStaffRecord_BTN(_ sender: Any) {
        if (userRole == "RestaurantManager"){
            performSegue(withIdentifier: "createNewStaffRecordSegue", sender: self)
        }
        else{
            print("You do not have access")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
