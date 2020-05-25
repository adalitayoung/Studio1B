//
//  EditDiscount.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 2/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class EditDiscount: StaffMenu {

    @IBOutlet weak var Name_TF: UITextField!
    @IBOutlet weak var Value_TF: UITextField!
    @IBOutlet weak var Description_TF: UITextField!
    @IBOutlet weak var ErrorMessage: UILabel!
    @IBOutlet weak var Update_BTN: UIButton!

    var discountName:String! = ""
    var discountDescription:String! = ""
    var discountValue:Double! = 0.0
    
    func errorChecking(DiscountName: String, DiscountValue: Double, DiscountDescription: String) -> Bool {
        var result = true;
        let errorColour = UIColor.red
        
        // Resetting the borders
        Name_TF.layer.borderWidth = 0
        Value_TF.layer.borderWidth = 0
        Description_TF.layer.borderWidth = 0
        
        if (DiscountName.isEmpty){
            Name_TF.layer.borderWidth = 1.0
            Name_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (Value_TF.text!.isEmpty) || (DiscountValue < 0.0) || (DiscountValue > 1.0) {
            Value_TF.layer.borderWidth = 1.0
            Value_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (DiscountDescription.isEmpty) {
            Description_TF.layer.borderWidth = 1.0
            Description_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        return result
    }
    
    
    func updateDiscount() {
        // Fetch original document
        let docRef = db.collection("Rewards").document(Name_TF.text!)
        
        if (discountName != Name_TF.text!){
            db.collection("Rewards").document(discountName).delete() {
            err in
                if let err = err {
                    print("Error deleting document")
                }
                else {
                    print("Document successfully deleted")
                }
            }
        }
        let DiscountValue = NSString(string: Value_TF.text!).doubleValue
        
        docRef.setData([
            "Deduction": DiscountValue,
            "Description": Description_TF.text
        ])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added. DiscountName= \(self.discountName). DiscountValue = \(self.discountValue)) ")
                
                let alert = UIAlertController(title: "Discount Updated",
                                                    message: "Discount Successfully Updated",
                                                    preferredStyle: .alert)
                // Add action buttons to it and attach handler functions if you want to
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
                    self.performSegue(withIdentifier: "discountUpdatedSegue", sender: self)
                }))
                
                self.present(alert, animated: true)
                
            }
        }
    }
    
    
    @IBAction func Update_BTN(_ sender: Any) {
        let errorsChecked = self.errorChecking(DiscountName: self.Name_TF.text!, DiscountValue: NSString(string: Value_TF.text!).doubleValue, DiscountDescription: self.Description_TF.text!)
        if (errorsChecked){
            updateDiscount()
        }
        else {
            ErrorMessage.textColor = UIColor.red
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name_TF.text! = discountName
        Value_TF.text! = String(discountValue)
        Description_TF.text! = discountDescription
        ErrorMessage.textColor = UIColor.white
        print(discountName)
        print(discountDescription)
        print(discountValue)
        
        if (userRole != "RestaurantManager"){
            Update_BTN.isEnabled = false
            Update_BTN.backgroundColor = UIColor.gray
        }
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
