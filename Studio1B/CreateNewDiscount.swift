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
                print("Document added. DiscountName= \(DiscountName). DiscountValue = \(DiscountValue)) ")
                
                let alert = UIAlertController(title: "Discount Created",
                                                    message: "Discount Successfully Created",
                                                    preferredStyle: .alert)
                // Add action buttons to it and attach handler functions if you want to
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
                    self.performSegue(withIdentifier: "discountCreatedSegue", sender: self)
                }))
                
                self.present(alert, animated: true)
                
            }
        }
    }
    
    func errorChecking(DiscountName: String, DiscountValue: Double, DiscountDescription: String){
        let result = true;
        
        let errorColour = UIColor.red
        if (DiscountName_TF.text!.isEmpty){
            DiscountName_TF.borderColor = errorColour.cgColor
            result = false
        }
        if (Double(DiscountValue_TF.text!) == nil) || (Double(DiscountValue_TF.text!) < 0) || (Double(DiscountValue_TF.text!)>1) {
            DiscountValue_TF.borderColor = errorColour.cgColor
            result = false
        }
        if (DiscountDescription_TF.text!.isEmpty) {
            DiscountDescription_TF.borderColor = errorColour.cgColor
            result = false
        }

        return result
    }

    @IBAction func submitNewDiscount_BTN(_ sender: Any) {
        
        let DiscountValue = NSString(string: DiscountValue_TF.text!).doubleValue
        
        let alert = UIAlertController(title: "Already Exists",
                                            message: "This discount already exists, do you want to override it?",
                                            preferredStyle: .alert)
        // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Override", style: .destructive, handler: { action in
            self.createRecord(DiscountName: self.DiscountName_TF.text!, DiscountValue: DiscountValue, DiscountDescription: self.DiscountDescription_TF.text!)
        }))


        let errorsChecked = self.errorChecking(DiscountName: self.DiscountName_TF.text!, DiscountValue: DiscountValue, DiscountDescription: self.DiscountDescription_TF.text!)
        
        if (errorsChecked) {
            // Check if the discount already exists
            let docRef = db.collection("Rewards").document(DiscountName_TF.text!)

            docRef.getDocument{(document, error) in
                
                if let document = document, document.exists {
                    // Show error message, choose new name or overwrite existing
                    print("Document Exists")

                // Show the alert by presenting it
                self.present(alert, animated: true)
                    
                }
                else {
                    self.createRecord(DiscountName: self.DiscountName_TF.text!, DiscountValue: DiscountValue, DiscountDescription: self.DiscountDescription_TF.text!)
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
