//
//  CustomersLogingIn.swift
//  Studio1B
//
//  Created by David Bolis on 13/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class CustomersLogingIn: UIViewController {
    @IBOutlet weak var UserNameTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var IncorrectMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IncorrectMessage.isHidden = true
    }
    
    @IBAction func LogInBtn(_ sender: Any) {
        if ((UserNameTxt?.text) != nil) && PasswordTxt?.text != ""{
            if UserNameTxt.text == "FoodApp" && PasswordTxt.text == "123456"{
                performSegue(withIdentifier: "logInSuccess", sender: self)
            } else {
                IncorrectMessage.isHidden = false
            }
        }
        
        
    }
    
    

}
