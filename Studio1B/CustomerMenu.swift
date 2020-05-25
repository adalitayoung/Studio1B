//
//  CustomerMenu.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 7/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class CustomerMenu: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Menu_BTN(_ sender: Any) {
        performSegue(withIdentifier: "toFoodMenu", sender: self)
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
