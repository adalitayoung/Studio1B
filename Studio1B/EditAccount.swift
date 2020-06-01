//
//  EditAccount.swift
//  Studio1B
//
//  Created by David Bolis on 31/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class EditAccount: UIViewController {

  
    @IBOutlet weak var MobileTextField: UITextField!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser!.uid
    var UserEmail = Auth.auth().currentUser!.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetUser()

        
    }
    func GetUser(){
        
        db.collection("Customer").whereField("CustomerUID", isEqualTo: "\(userID)").addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                
                
                let CustomerFirst = i.document.get("FirstName") as! String
                let Customerlast = i.document.get("LastName") as! String
                let CustomerMobilee = i.document.get("Mobile") as! String
                let Customeremail = i.document.get("Email") as! String
                let CustomerPassword = i.document.get("Password") as! String
                DispatchQueue.main.async {
                    self.FirstName.text = CustomerFirst
                    self.LastName.text = Customerlast
                    self.MobileTextField.text = CustomerMobilee
                    self.EmailTextField.text = Customeremail
                   
                    
                }
            }
        }
}
    
    
    @IBAction func SubmitBtn(_ sender: Any) {
        EditInformatino()
         dismiss(animated: false)
    }
    
    func EditInformatino(){
        db.collection("Customer").document(UserEmail!).updateData(["FirstName": "\(FirstName.text!)", "LastName": "\(LastName.text!)", "Mobile":"\(MobileTextField.text!)", "Email": "\(EmailTextField.text!)"])
        
    }
    
}
