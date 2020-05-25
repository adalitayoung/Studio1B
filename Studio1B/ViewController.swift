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
    
    @IBAction func logOut_btn(_ sender: Any) {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        do {
            defer{
                performSegue(withIdentifier: "customerLogOut", sender: self)
            }
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error Signing out.")
        }
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
    
    @IBAction func LogOutBtn(_ sender: Any) {
        LogCustomerOut()
    }
    
    func LogCustomerOut(){
        try! Auth.auth().signOut()
        
       
    }
    
}

