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
    
    lazy var DiscountName = DiscountName_TF.text!
    lazy var DiscountValue = Double(DiscountValue_TF.text!)
    lazy var DiscountDescription = DiscountDescription_TF.text!
    
    func createRecord(DiscountName: String, DiscountValue: Double, DiscountDescription: String) {
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
    
//    func handleOverride(DiscountName: String, DiscountValue: Float, _ DiscountDescription: String) -> (_ alertAction:UIAlertAction) -> () {
//        self.createRecord(DiscountName:DiscountName,DiscountValue:DiscountValue,DiscountDescription:DiscountDescription)
//    }
    
    @IBAction func submitNewDiscount_BTN(_ sender: Any) {
        
        let alert = UIAlertController(title: "Already Exists",
                                            message: "This discount already exists, do you want to override it?",
                                            preferredStyle: .alert)
               // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Override", style: .destructive, handler: { action in
            
        self.createRecord(DiscountName: self.DiscountName, DiscountValue: self.DiscountValue!, DiscountDescription: self.DiscountDescription)

//            let docRef = self.db.collection("Rewards").document(self.DiscountName)
//
//            docRef.setData([
//                "Deduction": self.DiscountValue,
//                "Description": self.DiscountDescription
//            ])
//            { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added")
//                }
//            }
        }))

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
                    
                    self.createRecord(DiscountName: self.DiscountName, DiscountValue: self.DiscountValue!, DiscountDescription: self.DiscountDescription)
                        
//                    let docRef = self.db.collection("Rewards").document(DiscountName)
//
//                    docRef.setData([
//                        "Deduction": DiscountValue,
//                        "Description": DiscountDescription
//                    ])
//                { err in
//                    if let err = err {
//                        print("Error adding document: \(err)")
//                    } else {
//                        print("Document added")
//                    }
//                }
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
