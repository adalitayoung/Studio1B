//
//  submitButton.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 22/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class PositionSelector: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // change to database value
    
    var selectedPosition: String?
    var positionList = ["Wait Staff", "Restaurant Manager", "Bar Staff"]
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positionList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positionList[row]
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPosition = positionList[row]
        textFiled.text = selectedPosition
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textFiled.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textFiled.inputAccessoryView = toolBar
    }
    
    @objc func action() {
       view.endEditing(true)
    }


}
