import UIKit

class CreateNewStaffRecord: StaffMenu {

func createRecord(AccountName: String, AccountNumber: Int, BSBNumber: Int, ContactNumber: Int, DateOfBirth: String, Email: String,
                    FirstName: String, LastName: String, Role: String) {
        
        let documentID = FirstName_TF.text!+" "+LastName_TF.text!
        let docRef = db.collection("Staff").document(documentID)

        // Convert DOB to date
        

        docRef.setData([
            "AccountName": AccountNumber,
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
            // Do we need this?
            // self.DiscountName_TF.text?.removeAll()
            // self.DiscountValue_TF.text?.removeAll()
            // self.DiscountDescription_TF.text?.removeAll()
        }


    }
    
    
    @IBAction func submitNewStaffRecord_BTN(_ sender: Any) {
        
        let AccountNumber = NSString(string: AccountNumber_TF.text!).intValue
        let BSBNumber = NSString(string: BSBNumber_TF.text!).intValue
        let ContactNumber = NSString(string: ContactNumber_TF.text!).intValue

        let alert = UIAlertController(title: "Already Exists",
                                            message: "This discount already exists, do you want to override it?",
                                            preferredStyle: .alert)
        // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Override", style: .destructive, handler: { action in
            self.createRecord(AccountName: self.AccountName_TF.text!, AccountNumber: AccountNumber, BSBNumber: BSBNumber, ContactNumber: ContactNumber, DateOfBirth: self.DateOfBirth_TF.text!, Email: self.Email_TF.text!,
                    FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, Role: self.Role_TF.text!)
        }))

        if !(AccountName_TF.text!.isEmpty) && !(DateOfBirth_TF.text!.isEmpty) && (Int(AccountNumber_TF.text!) != nil) && (Int(BSBNumber_TF.text!) != nil)
                && (Int(ContactNumber_TF.text!) != nil) && !(Email_TF.text!.isEmpty) && !(FirstName_TF.text!.isEmpty) && !(LastName_TF.text!.isEmpty) && !(Role_TF.text!.isEmpty){
            
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
                    self.createRecord(AccountName: self.AccountName_TF.text!, AccountNumber: AccountNumber, BSBNumber: BSBNumber, ContactNumber: ContactNumber, DateOfBirth: self.DateOfBirth_TF.text!, Email: self.Email_TF.text!,
                        FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, Role: self.Role_TF.text!)
                }
            }
        }
        else {
            MissingDetailsMessage.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        MissingDetailsMessage.isHidden = true
    }



}