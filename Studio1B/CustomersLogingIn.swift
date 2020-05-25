//
//  CustomersLogingIn.swift
//  Studio1B
//
//  Created by David Bolis on 13/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class CustomersLogingIn: LoginRegisterView {
    
    @IBOutlet weak var EmaillTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var IncorrectMessage: UILabel!
    @IBOutlet weak var LogInBtnOutlet: UIButton!
    @IBOutlet weak var ForgotPasswordBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IncorrectMessage.isHidden = true
        LogInBtnOutlet.layer.cornerRadius = 10
    }
    
    @IBAction func LogInBtn(_ sender: Any) {

        GetUserInfo()  
        }
        
    @IBAction func ForgotPasswordBTNA(_ sender: Any) {
        ToForgotPassword()
    }
    func GetUserInfo(){
         if EmaillTxt.text != "" && PasswordTxt.text != ""{
                Auth.auth().signIn(withEmail: self.EmaillTxt.text!, password: self.PasswordTxt.text!) {(res, err) in
                    if err != nil{
                        self.IncorrectMessage.isHidden = false
                        self.IncorrectMessage.text = "\(err!.localizedDescription)"
                        print(err!.localizedDescription)
                    } else{
                        self.performSegue(withIdentifier: "ToMainPage", sender: self)
                    }
                }
            }

   
    }
    func ToForgotPassword(){
        performSegue(withIdentifier: "ToForgotPassword", sender: self)
    }
    func ToMainPageS(){
         performSegue(withIdentifier: "ToMainPage", sender: self)
    }

}
