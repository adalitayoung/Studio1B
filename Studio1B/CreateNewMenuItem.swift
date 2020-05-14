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
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBOutlet weak var ErrorMessage: UILabel!
    let db = Firestore.firestore()
    
    var list = ["Dessert","Drinks","Dinner"]
    var menuType = ""
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backFromNewMenuItem", sender: self)
    }
    
    func errorChecking() -> Bool {
        var result = true;
        let errorColour = UIColor.red
        
        // Resetting the borders
        name_tf.layer.borderWidth = 0
        dinnerPrice_tf.layer.borderWidth = 0
        lunchPrice_tf.layer.borderWidth = 0
        description_tf.layer.borderWidth = 0
        
        if (name_tf.text!.isEmpty){
            name_tf.layer.borderWidth = 1.0
            name_tf.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (dinnerPrice_tf.text!.isEmpty) || ( NSString(string: dinnerPrice_tf.text!).doubleValue <= 0.0)  {
            dinnerPrice_tf.layer.borderWidth = 1.0
            dinnerPrice_tf.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (lunchPrice_tf.text!.isEmpty) || (NSString(string: lunchPrice_tf.text!).doubleValue <= 0.0)  {
            lunchPrice_tf.layer.borderWidth = 1.0
            lunchPrice_tf.layer.borderColor = errorColour.cgColor
            result = false
        }
        if (description_tf.text!.isEmpty) {
            description_tf.layer.borderWidth = 1.0
            description_tf.layer.borderColor = errorColour.cgColor
            result = false
        }
        return result
    }
    
    func createNewItem() {
        db.collection("Menu").document(name_tf.text!).setData([
            "Description": description_tf.text!,
            "Dinner Price": NSString(string: dinnerPrice_tf.text!).doubleValue,
            "Lunch Price": NSString(string: lunchPrice_tf.text!).doubleValue,
            "Type": menuType
        ]) {err in
            if let err = err {
                print(err)
            }
            else{
                print("Document added")
                self.performSegue(withIdentifier: "menuItemAdded", sender: self)
            }
        }
    }
    
    @IBAction func create_btn(_ sender: Any) {
        if (errorChecking()){
            createNewItem()
        }
        else{
            ErrorMessage.isHidden = false
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.menuType = self.list[row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorMessage.isHidden = true
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
    }

}
