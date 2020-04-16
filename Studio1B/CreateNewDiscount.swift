//
//  CreateDiscountMenu.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 16/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class CreateNewDiscount: StaffMenu {

    @IBOutlet weak var DiscountName_TF: UITextField!
    @IBOutlet weak var DiscountValue_TF: UITextField!
    @IBOutlet weak var DiscountDescription_TF: UITextField!
    @IBOutlet weak var MissingDetailsMessage: UILabel!
    
//    func handleOverride(DiscountName: String, DiscountValue: Float, _ DiscountDescription: String) -> (_ alertAction:UIAlertAction) -> () {
//        self.createRecord(DiscountName:DiscountName,DiscountValue:DiscountValue,DiscountDescription:DiscountDescription)
//    }
    
    @IBAction func submitNewDiscount_BTN(_ sender: Any) {
        let DiscountName: String = DiscountName_TF.text!
        // let DiscountValue: Double = DiscountValue_TF.text!
        var DiscountValue = (DiscountValue_TF.text as! NSString).floatValue
        let DiscountDescription: String = DiscountDescription_TF.text!
        
        let alert = UIAlertController(title: "Already Exists",
                                            message: "This discount already exists, do you want to override it?",
                                            preferredStyle: .alert)
               // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Override", style: .destructive, handler: {action in self.handleOverride(DiscountName: String, DiscountValue: <#Float#>, <#String#>)
//
//
//    }))
//        alert.addAction(UIAlertAction(title: "Override", style: .destructive, handler: {action in
//
//            let docRef = db.collection("Rewards").document(DiscountName)
//                docRef.setData([
//                    "Deduction": DiscountValue,
//                    "Description": DiscountDescription
//                ])
//                { err in
//                    if let err = err {
//                        print("Error adding document: \(err)")
//                    } else {
//                        print("Document added")
//                    }
//                }
//        }))

        if !(DiscountName.isEmpty) && (DiscountValue != nil){
            // Check if the discount already exists
            let docRef = db.collection("Rewards").document(DiscountName)

            docRef.getDocument{(document, error) in
                if let document = document, document.exists {
                    // Show error message, choose new name or overwrite existing
                    print("Document Exists")

                // Show the alert by presenting it
                self.present(alert, animated: true)


                }
                else {
                  //  self.createRecord(DiscountName: <#String#>, DiscountValue: <#Double#>, DiscountDescription: <#String#>)
                    self.createRecord(DiscountName:DiscountName, DiscountValue:DiscountValue, DiscountDescription:DiscountDescription)
//                    docRef.setData([
//                        "Deduction": DiscountValue,
//                        "Description": DiscountDescription
//                    ])
//                    { err in
//                        if let err = err {
//                            print("Error adding document: \(err)")
//                        } else {
//                            print("Document added")
//                        }
//                    }
                }
            }
        }
        else {
            MissingDetailsMessage.isHidden = false
        }
    }
//
    func createRecord(DiscountName: String, DiscountValue: Float, DiscountDescription: String) {

        let docRef = db.collection("Rewards").document(DiscountName)

        docRef.setData([
            "Deduction": DiscountValue,
            "Description": DiscountDescription
        ])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
        MissingDetailsMessage.isHidden = true
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
