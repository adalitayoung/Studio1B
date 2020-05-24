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

    let db = Firestore.firestore()
    
//    @IBAction func viewMenuSegue(_ sender: Any) {
//        performSegue(withIdentifier: "viewMenuSegue", sender: self)
//    }
    
    @IBAction func newBookingSegue(_ sender: Any) {
        performSegue(withIdentifier: "newBookingSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OrderAMealBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MealOrderingOne") as! MealOrderingOne
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
}

