//
//  ForgotPasswordPage.swift
//  Studio1B
//
//  Created by David Bolis on 7/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordPage: UIViewController {
    @IBOutlet weak var SendBtn: UIButton!
    
    @IBOutlet weak var emailtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        SendBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    

    @IBAction func ResetPassword(_ sender: Any) {
        resetPassword()
    }
    func resetPassword(){
        Auth.auth().sendPasswordReset(withEmail: emailtextField.text!) { (error) in
            if error == nil{
                print("Success")
                self.dismiss(animated: true)
            } else {
                print("Not Success")
            }
        }
    }

}
