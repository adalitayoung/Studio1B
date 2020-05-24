//
//  ViewController.swift
//  Studio1B
//
//  Created by David Bolis on 16/3/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OrderAMealBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MealOrderingOne") as! MealOrderingOne
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func LogOutBtn(_ sender: Any) {
        LogCustomerOut()
    }
    
    func LogCustomerOut(){
        try! Auth.auth().signOut()
        
       
    }
    
}

