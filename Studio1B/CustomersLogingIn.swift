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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IncorrectMessage.isHidden = true
        LogInBtnOutlet.layer.cornerRadius = 10
    }
    
    @IBAction func LogInBtn(_ sender: Any) {

        GetUserInfo()  
        }
        
    func GetUserInfo(){
        //let db = Firestore.firestore()
        db.collection("Customer").getDocuments{ (snap, err) in
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
            for i in snap!.documents{
                if i.documentID == self.EmaillTxt.text {
                   let Email =  i.get("Email") as! String
                   let Password = i.get("Password") as! String
                    if Email == self.EmaillTxt.text && Password == self.PasswordTxt.text{
                        self.ToMainPageS()
                    } else {
                        self.IncorrectMessage.text = "Incorrect Email or Password"
                        self.IncorrectMessage.isHidden = false
                    }
                    
                } else {
                    self.IncorrectMessage.text = "Incorrect Email or Password"
                    self.IncorrectMessage.isHidden = false
                    
                }
            }
    }
   
    }
    
    func ToMainPageS(){
         performSegue(withIdentifier: "ToMainPage", sender: self)
    }

}
