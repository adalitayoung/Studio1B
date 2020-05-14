//
//  EditMenuItem.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 11/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class EditMenuItem: StaffMenu {

    @IBOutlet weak var name_tf: UITextField!
    
    @IBOutlet weak var description_tf: UITextField!
    @IBOutlet weak var dinnerPrice_tf: UITextField!
    @IBOutlet weak var lunchPrice_tf: UITextField!
    
    // put in error message
    
    @IBOutlet weak var update_btn: UIButton!
    
    var menuItem = [String:Any]()
    
    func updateMenuItem() {
        if (menuItem["Name"] as! String != name_tf.text!){
            db.collection("Menu").document(menuItem["Name"] as! String).delete() { err in
                if let err = err {
                    print(err)
                }
                else {
                    print("Document deleted")
                }
            }
        }
        db.collection("Menu").document(name_tf.text!).setData([
            "Description":description_tf.text!,
            "Dinner Price": NSString(string: dinnerPrice_tf.text!).doubleValue,
            "Lunch Price": NSString(string: lunchPrice_tf.text!).doubleValue,
            "Type": menuItem["Type"]
        ]) { err in
            if let err = err {
                print(err)
            }
            else{
                print("Document updated")
                let alert = UIAlertController(title: "Item Updated Updated",
                                                    message: "Menu Item Successfully Updated",
                                                    preferredStyle: .alert)
                // Add action buttons to it and attach handler functions if you want to
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
                    self.performSegue(withIdentifier: "menuItemUpdated", sender: self)
                }))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func update_btn(_ sender: Any) {
//        let errorsChecked = self.errorChecking()
//            if (errorsChecked){
        updateMenuItem()

//            }
//            else {
                //ErrorMessage.textColor = UIColor.red
           // }
        
    }

        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(menuItem)
        
        // Assign variables from staff object to the fields.
        name_tf.text! = menuItem["Name"] as! String
        description_tf.text! = menuItem["Description"] as! String
        dinnerPrice_tf.text! = String(menuItem["Dinner Price"] as! Int)
        lunchPrice_tf.text! = String(menuItem["Lunch Price"] as! Int)
        //ErrorMessage.textColor = UIColor.white
        // Do any additional setup after loading the view.
        
    }
    
}
