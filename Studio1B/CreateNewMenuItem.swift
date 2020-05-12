//
//  CreateNewMenuItem.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 12/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//
import Firebase
import UIKit

class CreateNewMenuItem: UIViewController, UIPickerViewDelegate,
   UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var name_tf: UITextField!
    @IBOutlet weak var description_tf: UITextField!
    @IBOutlet weak var lunchPrice_tf: UITextField!
    @IBOutlet weak var dinnerPrice_tf: UITextField!
    @IBOutlet weak var menuType: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBOutlet weak var ErrorMessage: UILabel!
    let db = Firestore.firestore()
    
    var list = ["Dessert","Drinks","Dinner"]

    func errorChecking() -> Bool {
        return true
    }
    
        func createNewItem() {
            db.collection("Menu").document(name_tf.text!).setData([
                "Description": description_tf.text!,
                "Dinner Price": NSString(string: dinnerPrice_tf.text!).doubleValue,
                "Lunch Price": NSString(string: lunchPrice_tf.text!).doubleValue,
                "Type": menuType.text!
            ]) {err in
                if let err = err {
                    print(err)
                }
                else{
                    print("Document added")
                }
            }
        }
    
    @IBAction func create_btn(_ sender: Any) {
        if (errorChecking()){
            createNewItem()
        }
        else{
            //errorMessage.isHidden = false
        }
    }
    
        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
    
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
    
            return list.count
        }
    
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            self.view.endEditing(true)
            return list[row]
        }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
            self.menuType.text = self.list[row]
            self.dropDown.isHidden = true
        }
    
        func textFieldDidBeginEditing(_ textField: UITextField) {
    
            if textField == self.menuType {
                self.dropDown.isHidden = false
                //if you don't want the users to se the keyboard type:
    
                textField.endEditing(true)
            }
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
                // Do any additional setup after loading the view.
        
        
    }

}
