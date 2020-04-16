//
//  CreateDiscountMenu.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 16/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class CreateDiscount: StaffMenu {

    @IBOutlet weak var DiscountName_TF: UITextField!
    @IBOutlet weak var DiscountValue_TF: UITextField!
    @IBOutlet weak var DiscountDescription_TF: UITextField!
    @IBOutlet weak var MissingDetailsMessage: UILabel!
    
    @IBAction func submitNewDiscount_BTN(_ sender: Any) {
        let DiscountName: String = DiscountName_TF.text!
        let DiscountValue = Double(DiscountValue_TF.text!)
        let DiscountDescription: String = DiscountDescription_TF.text!

        if (DiscountName != nil) && (DiscountValue != nil){
            // Check if the discount already exists
            let docRef = db.collection("Rewards").document(DiscountName)

            docRef.getDocument{(document, error) in 
                if let document = document, document.exists {
                    // Show error message, choose new name or overwrite existing
                    print("Document Exists")

                } else {
                    db.collection("Rewards").document(DiscountName).setData([
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
