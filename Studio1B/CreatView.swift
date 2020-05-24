//
//  CreatView.swift
//  Studio1B
//
//  Created by David Bolis on 22/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase
class CreatView: UIViewController {
    var currentValue = 0
    
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var MobileNumber: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PasswordConfirmation: UITextField!
    @IBOutlet weak var DOB: UIDatePicker!
    
    @IBOutlet weak var ErrorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLbl.isHidden = true
        self.RegisterBtn.layer.cornerRadius = 10
    }
    
    
    @IBAction func RegisterBtnA(_ sender: Any) {
        
        if FirstName.text != "" && LastName.text != "" && UserEmail.text != "" && MobileNumber.text != "" && Password.text != "" && PasswordConfirmation.text != ""  {
            
            CreateUser(FirstName: FirstName.text!, LastName: LastName.text!, Age: "\(DOB )", Email: UserEmail.text!, Mobile: MobileNumber.text!, Password: Password.text!)
            
        }else{
            ErrorLbl.isHidden = false
            ErrorLbl.text = "Form Incomplete"
            ErrorLbl.textColor = .red
        }
        
        
    }
    
    func CreateUser(FirstName: String, LastName: String, Age: String , Email: String, Mobile: String, Password: String){
        Auth.auth().createUser(withEmail: Email, password: Password) { (res, err) in
            if err != nil{
                print((err!.localizedDescription))
                self.ErrorLbl.text = "\(err!.localizedDescription)"
                self.ErrorLbl.isHidden = false
                return
                
            }
            
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            let UserID = Auth.auth().currentUser?.uid
            
            switch user?.isEmailVerified {
            case true:
                print("Email Verified")
            case false:
                user?.sendEmailVerification { (err) in
                    if err != nil{
                        print((err?.localizedDescription)!)
                        return
                    }
                    
                    
                }
            default: break
            }
            
            db.collection("Customer").document("\(Email)").setData(["FirstName": FirstName, "LastName": LastName, "Age": Age, "Email": Email, "Mobile": Mobile, "Password": Password, "CustomerUID": UserID]){ (err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
            }
            self.dismiss(animated: true)
        }
        
        
    }
}
