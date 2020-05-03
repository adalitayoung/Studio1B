//
//  EditStaff.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 3/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class EditStaff: StaffMenu {
    
        @IBOutlet weak var FirstName_TF: UITextField!
        @IBOutlet weak var LastName_TF: UITextField!
        @IBOutlet weak var Email_TF: UITextField!
        @IBOutlet weak var ContactNumber_TF: UITextField!
        @IBOutlet weak var DateOfBirth_TF: UITextField!
        @IBOutlet weak var Role_TF: UITextField!
        @IBOutlet weak var AccountName_TF: UITextField!
        @IBOutlet weak var AccountNumber_TF: UITextField!
        @IBOutlet weak var ErrorMessage: UILabel!
        @IBOutlet weak var BSBNumber_TF: UITextField!
        @IBOutlet weak var Password_TF: UITextField!
        @IBOutlet weak var Update_BTN: UIButton!
    
        var staff = [String:Any]()
    
        //func errorChecking() -> Bool{}
    
        func updateStaff(){
    
        }
    
        @IBAction func Update_BTN(_ sender: Any) {
//            let errorsChecked = self.errorChecking()
//            if (errorsChecked){
//                updateStaff()
//            }
//            else {
//                ErrorMessage.textColor = UIColor.red
//            }
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Assign variables from staff object to the fields.
    
    
    
            print(staff)
    
            ErrorMessage.textColor = UIColor.white
            // Do any additional setup after loading the view.
        }
}

