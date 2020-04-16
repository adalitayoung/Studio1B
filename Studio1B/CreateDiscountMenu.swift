//
//  CreateDiscountMenu.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 16/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class CreateDiscountMenu: StaffMenu {

    @IBOutlet weak var DiscountName_TF: UITextField!
    @IBOutlet weak var DiscountValue_TF: UITextField!
    
    @IBAction func submitNewDiscount_BTN(_ sender: Any) {
        let DiscountName: String = DiscountName_TF.text!
        let DiscountValue = Double(DiscountValue_TF.text!)
        
        db.collection("Rewards").document(DiscountName).setData([
            "Deduction": DiscountValue
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
