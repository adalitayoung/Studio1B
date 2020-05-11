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
