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
    
    @IBOutlet var dobPicker: [UIDatePicker]!
    
    
    func createRecord(AccountName: String, AccountNumber: Int, BSBNumber: Int, ContactNumber: String, DateOfBirth: String, Email: String,

                    FirstName: String, LastName: String, Role: String) {
        
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
            "Role": Role
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

                    FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, Role: self.Role_TF.text!)
        }))

        if !(AccountName_TF.text!.isEmpty) && !(DateOfBirth_TF.text!.isEmpty) && (Int(AccountNumber_TF.text!) != nil) && (Int(BSBNumber_TF.text!) != nil)
            && !(ContactNumber_TF.text!.isEmpty) && !(Email_TF.text!.isEmpty) && !(FirstName_TF.text!.isEmpty) && !(LastName_TF.text!.isEmpty) && !(Role_TF.text!.isEmpty){


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

                        FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, Role: self.Role_TF.text!)
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

