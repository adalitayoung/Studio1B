//
//  CreateNewStaffRecord.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 18/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class CreateNewStaffRecord: StaffMenu {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var FirstName_TF: UITextField!
    @IBOutlet weak var LastName_TF: UITextField!
    @IBOutlet weak var Email_TF: UITextField!
    @IBOutlet weak var ContactNumber_TF: UITextField!
    @IBOutlet weak var DateOfBirth_TF: UITextField!
    @IBOutlet weak var Role_TF: UITextField!
    @IBOutlet weak var AccountName_TF: UITextField!
    @IBOutlet weak var AccountNumber_TF: UITextField!
    @IBOutlet weak var MissingDetailsMessage: UILabel!
    @IBOutlet weak var BSBNumber_TF: UITextField!
    @IBOutlet weak var Password_TF: UITextField!
    @IBOutlet weak var create_BTN: UIButton!
    
    @IBOutlet var dobPicker: [UIDatePicker]!
    
    
    func createRecord(AccountName: String, AccountNumber: Int, BSBNumber: Int, ContactNumber: String, DateOfBirth: String, Email: String,

                    FirstName: String, LastName: String, Role: String, Password: String) {
        
        let documentID = FirstName_TF.text!+" "+LastName_TF.text!
        let docRef = db.collection("Staff").document(documentID)

        // Convert DOB to date
        
        
        docRef.setData([
            "AccountName": AccountName,
            "AccountNumber": AccountNumber,
            "BSBNumber": BSBNumber,
            "ContactNumber": ContactNumber,
            "DOB": DateOfBirth,
            "Email": Email,
            "FirstName": FirstName,
            "LastName": LastName,
            "Role": Role,
            "Password": Password
        ])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added.")
                
                let alert = UIAlertController(title: "Staff Record Created",
                                                    message: "Staff Record Successfully Created",
                                                    preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
                    self.performSegue(withIdentifier: "staffRecordCreated", sender: self)
                }))
                
                self.present(alert, animated: true)
                
            }
        }


    }
    
    func errorChecking(AccountName: String, AccountNumber: String, BSBNumber: String, ContactNumber: String, DateOfBirth: String, Email: String,
                    FirstName: String, LastName: String, Role: String, Password: String) -> Bool {
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
        
        if (AccountName.isEmpty){
            AccountName_TF.layer.borderWidth = 1.0
            AccountName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        let regexDOB = try! NSRegularExpression(pattern: #"^([0-2][0-9]|(3)[0-1])(\/)(((0)[1-9])|((1)[0-2]))(\/)\d{4}$"#)
        let results = regexDOB.matches(in:DateOfBirth,range: NSRange(DateOfBirth.startIndex..., in: DateOfBirth))
        print(results)
        
        if (DateOfBirth.isEmpty) || (results.count == 0){
            DateOfBirth_TF.layer.borderWidth = 1.0
            DateOfBirth_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        if (AccountNumber.isEmpty){
            AccountNumber_TF.layer.borderWidth = 1.0
            AccountNumber_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        
        print(BSBNumber.count)
        // Limit to 6
        if (BSBNumber.isEmpty) || (BSBNumber.count != 6) {
            BSBNumber_TF.layer.borderWidth = 1.0
            BSBNumber_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        // Limit to 10
        if (ContactNumber.isEmpty) || (ContactNumber.count != 10){
            ContactNumber_TF.layer.borderWidth = 1.0
            ContactNumber_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        let regexEmail = try! NSRegularExpression(pattern: #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#)
        let emailResults = regexEmail.matches(in:Email,range: NSRange(Email.startIndex..., in: Email))
        print(emailResults)

        // Has to have @ and .com
        if (Email.isEmpty) || (emailResults.count == 0){
            Email_TF.layer.borderWidth = 1.0
            Email_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (FirstName.isEmpty){
            FirstName_TF.layer.borderWidth = 1.0
            FirstName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (LastName.isEmpty){
            LastName_TF.layer.borderWidth = 1.0
            LastName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (Role.isEmpty){
            Role_TF.layer.borderWidth = 1.0
            Role_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        if (Password.isEmpty){
            Password_TF.layer.borderWidth = 1.0
            Password_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        return result
    }

    @IBAction func submitNewStaffRecord_BTN(_ sender: Any) {

        let AccountNumber = NSString(string: AccountNumber_TF.text!).intValue
        let BSBNumber = NSString(string: BSBNumber_TF.text!).intValue

        let alert = UIAlertController(title: "Already Exists",
                                            message: "This staff member already exists, do you want to override it?",
                                            preferredStyle: .alert)
        // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Override", style: .destructive, handler: { action in
            self.createRecord(AccountName: self.AccountName_TF.text!, AccountNumber: Int(AccountNumber), BSBNumber: Int(BSBNumber), ContactNumber: self.ContactNumber_TF.text!, DateOfBirth: self.DateOfBirth_TF.text!, Email: self.Email_TF.text!,
                    FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, Role: self.Role_TF.text!, Password: self.Password_TF.text!)
        }))

        let AccountNumberString = NSString(string: AccountNumber_TF.text!)
        let BSBNumberString = NSString(string: BSBNumber_TF.text!)
        
        let errorsChecked = self.errorChecking(AccountName: self.AccountName_TF.text!, AccountNumber: AccountNumberString as String, BSBNumber: BSBNumberString as String, ContactNumber: self.ContactNumber_TF.text!, DateOfBirth: self.DateOfBirth_TF.text!, Email: self.Email_TF.text!,
                    FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, Role: self.Role_TF.text!, Password: self.Password_TF.text!)

        if (errorsChecked) {
            // Check if the discount already exists
            let documentID = FirstName_TF.text!+" "+LastName_TF.text!
            let docRef = db.collection("Staff").document(documentID)

            docRef.getDocument{(document, error) in

                if let document = document, document.exists {
                    // Show error message, choose new name or overwrite existing
                    print("Document Exists")

                    // Show the alert by presenting it
                    self.present(alert, animated: true)

                }
                else {
                    self.createRecord(AccountName: self.AccountName_TF.text!, AccountNumber: Int(AccountNumber), BSBNumber: Int(BSBNumber), ContactNumber: self.ContactNumber_TF.text!, DateOfBirth: self.DateOfBirth_TF.text!, Email: self.Email_TF.text!,

                        FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, Role: self.Role_TF.text!, Password: self.Password_TF.text!)
                }
            }
        }
        else {
            MissingDetailsMessage.textColor = UIColor.red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        MissingDetailsMessage.textColor = UIColor.white
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

