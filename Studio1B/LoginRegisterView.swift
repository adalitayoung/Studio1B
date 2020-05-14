//
//  LoginRegisterView.swift
//  Studio1B
//
//  Created by David Bolis on 22/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class LoginRegisterView: UIViewController {
 
    @IBOutlet weak var CreatAcBtn: UIButton!
    @IBOutlet weak var LogoImage: UIImageView!
    @IBOutlet weak var LoginBTNP: UIButton!
    
    let db = Firestore.firestore()
    @IBAction func staffLogin_BTN(_ sender: Any) {
        performSegue(withIdentifier: "toStaffLoginSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: UIImage(named: "wood.png")!)
        self.LoginBTNP?.layer.cornerRadius = 10
        self.CreatAcBtn?.layer.cornerRadius = 10
        self.LogoImage?.layer.cornerRadius = 10
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
