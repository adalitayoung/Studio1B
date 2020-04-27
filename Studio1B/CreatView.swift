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
    @IBOutlet weak var YearsLbl: UILabel!
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var UserEmail: UITextField!
    @IBOutlet weak var MobileNumber: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PasswordConfirmation: UITextField!
    @IBAction func AgeSlider(_ sender: UISlider) {
       currentValue = Int(sender.value)
        YearsLbl.text = "\(currentValue) Years"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.RegisterBtn.layer.cornerRadius = 10
    }
    
    
    @IBAction func RegisterBtnA(_ sender: Any) {
    
        if FirstName.text != "" && LastName.text != "" && UserEmail.text != "" && MobileNumber.text != "" && Password.text != "" && PasswordConfirmation.text != "" {

            CreateUser(FirstName: FirstName.text!, LastName: LastName.text!, Age: "\(currentValue)", Email: UserEmail.text!, Mobile: MobileNumber.text!, Password: Password.text!)
        }
        
        
        
        
        
    }
    
    func CreateUser(FirstName: String, LastName: String, Age: String , Email: String, Mobile: String, Password: String){
        let db = Firestore.firestore()
       
        
        db.collection("Customer").document("\(Email)").setData(["FirstName": FirstName, "LastName": LastName, "Age": Age, "Email": Email, "Mobile": Mobile, "Password": Password]){ (err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
        }
        
    }

}
