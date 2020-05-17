//
//  EditStaff.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 3/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import FirebaseAuth

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
    let userId = UserDefaults.standard.object(forKey: "userId") as! String

    func errorChecking() -> Bool{
        var result = true;
        let errorColour = UIColor.red

        // Resetting the borders
        AccountName_TF.layer.borderWidth = 0
        DateOfBirth_TF.layer.borderWidth = 0
        AccountNumber_TF.layer.borderWidth = 0
        BSBNumber_TF.layer.borderWidth = 0
        ContactNumber_TF.layer.borderWidth = 0
        Email_TF.layer.borderWidth = 0
        FirstName_TF.layer.borderWidth = 0
        Role_TF.layer.borderWidth = 0
        LastName_TF.layer.borderWidth = 0
        Password_TF.layer.borderWidth = 0
        
        if (AccountName_TF.text!.isEmpty){
            AccountName_TF.layer.borderWidth = 1.0
            AccountName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        let regexDOB = try! NSRegularExpression(pattern: #"^([0-2][0-9]|(3)[0-1])(\/)(((0)[1-9])|((1)[0-2]))(\/)\d{4}$"#)
        let results = regexDOB.matches(in:DateOfBirth_TF.text!,range: NSRange(DateOfBirth_TF.text!.startIndex..., in: DateOfBirth_TF.text!))
        print(results)
        
        if (DateOfBirth_TF.text!.isEmpty) || (results.count == 0){
            DateOfBirth_TF.layer.borderWidth = 1.0
            DateOfBirth_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        if (AccountNumber_TF.text!.isEmpty){
            AccountNumber_TF.layer.borderWidth = 1.0
            AccountNumber_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        
        print(BSBNumber_TF.text!.count)
        // Limit to 6
        if (BSBNumber_TF.text!.isEmpty) || (BSBNumber_TF.text!.count != 6) {
            BSBNumber_TF.layer.borderWidth = 1.0
            BSBNumber_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        // Limit to 10
        if (ContactNumber_TF.text!.isEmpty) || (ContactNumber_TF.text!.count != 10){
            ContactNumber_TF.layer.borderWidth = 1.0
            ContactNumber_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        let regexEmail = try! NSRegularExpression(pattern: #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#)
        let emailResults = regexEmail.matches(in:Email_TF.text!,range: NSRange(Email_TF.text!.startIndex..., in: Email_TF.text!))
        print(emailResults)

        // Has to have @ and .com
        if (Email_TF.text!.isEmpty) || (emailResults.count == 0){
            Email_TF.layer.borderWidth = 1.0
            Email_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (FirstName_TF.text!.isEmpty){
            FirstName_TF.layer.borderWidth = 1.0
            FirstName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (LastName_TF.text!.isEmpty){
            LastName_TF.layer.borderWidth = 1.0
            LastName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (Role_TF.text!.isEmpty){
            Role_TF.layer.borderWidth = 1.0
            Role_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        if (Password_TF.text!.isEmpty){
            Password_TF.layer.borderWidth = 1.0
            Password_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        return result
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Staff Updated",
                                            message: "Staff Successfully Updated",
                                            preferredStyle: .alert)
        // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
            self.performSegue(withIdentifier: "staffUpdatedSegue", sender: self)
        }))
        
        self.present(alert, animated: true)
    }
    
    func updateStaff(){
        var documentID = (staff["FirstName"] as! String) + " " + (staff["LastName"] as! String)
        var tempID = FirstName_TF.text! + " " + LastName_TF.text!

        var docRef = db.collection("Staff").document(tempID)
        if (tempID != documentID) {
            db.collection("Staff").document(documentID).delete() {
                err in if let err = err {
                    print("Error updating document")
                }
                else{
                    print("Document updated")
                }
            }
        }

        docRef.setData([
            "AccountName": AccountName_TF.text!,
            "AccountNumber": NSString(string: AccountNumber_TF.text!).intValue,
            "BSBNumber": NSString(string: BSBNumber_TF.text!).intValue,
            "ContactNumber": ContactNumber_TF.text!,
            "DOB": DateOfBirth_TF.text!,
            "Email": Email_TF.text!,
            "FirstName": FirstName_TF.text!,
            "LastName": LastName_TF.text!,
            "Role": Role_TF.text!,
            "Password": Password_TF.text!
        ])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added.")
                if ((self.staff["Email"]) as! String != self.Email_TF.text!) || ((self.staff["Password"]) as! String != self.Password_TF.text!) || ((self.staff["Role"]) as! String != self.Role_TF.text!) {
                    Auth.auth().currentUser?.updateEmail(to: self.Email_TF.text!) {error in
                        if let error = error {
                            print(error)
                        }
                        else{
                            Auth.auth().currentUser?.updatePassword(to: self.Password_TF.text!) { error in
                                if let error = error {
                                    print(error)
                                }
                                else{
                                    UserDefaults.standard.removeObject(forKey: "userId")
                                    UserDefaults.standard.set(self.Email_TF.text!, forKey:"userId");
                                    UserDefaults.standard.removeObject(forKey: "userRole")
                                    UserDefaults.standard.set(self.Role_TF.text!, forKey:"userRole");
                                    UserDefaults.standard.synchronize()
                                    self.showAlert()
                                }
                            }
                        }
                    }
                }
                else{
                    self.showAlert()
                }
                
            }
        }
    }
        

    @IBAction func Update_BTN(_ sender: Any) {
        let errorsChecked = self.errorChecking()
        if (errorsChecked && (userId == (staff["Email"] as! String))){
            Update_BTN.isEnabled = false
            Update_BTN.backgroundColor = UIColor.gray
            updateStaff()
        }
        else {
            ErrorMessage.textColor = UIColor.red
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign variables from staff object to the fields.
        FirstName_TF.text! = staff["FirstName"] as! String
        LastName_TF.text! = staff["LastName"] as! String
        Email_TF.text! = staff["Email"] as! String
        ContactNumber_TF.text! = staff["ContactNumber"] as! String
        DateOfBirth_TF.text! = staff["DOB"] as! String
        Role_TF.text! = staff["Role"] as! String
        AccountName_TF.text! = staff["AccountName"] as! String
        AccountNumber_TF.text! = String(staff["AccountNumber"] as! Int)
        BSBNumber_TF.text! = String(staff["BSBNumber"] as! Int)
        Password_TF.text! = staff["Password"] as! String

        ErrorMessage.textColor = UIColor.white
        
        if (userId != staff["Email"] as! String){
            Update_BTN.isEnabled = false
            Update_BTN.backgroundColor = UIColor.gray
        }
        // Do any additional setup after loading the view.
    }
}

