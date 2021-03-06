//
//  StaffLogin.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 27/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StaffLogin: LoginRegisterView {
    
    @IBOutlet weak var Email_TF: UITextField!
    @IBOutlet weak var Password_TF: UITextField!
    @IBOutlet weak var IncorrectMessage: UILabel!
    
    
    func errorChecking(Email: String, Password: String)  {
        var result = true
        let errorColour = UIColor.red

        Email_TF.layer.borderWidth = 0
        Password_TF.layer.borderWidth = 0
        
        db.collection("Staff").whereField("Email", isEqualTo: Email).limit(to: 1).getDocuments() { (querySnapshot, err) in
            print("Email = " + Email)
            print(querySnapshot)
                if let err = err {
                    print("Firebase error fetching staff")
                }
                else {
                    print(querySnapshot!.documents)
                    if (querySnapshot!.documents.count == 0) {
                        print("Error finding staff member")
                        self.IncorrectMessage.text! = "Staff member does not exist"
                        result = false
                        self.IncorrectMessage.isHidden = false
                        self.Email_TF.layer.borderWidth = 1.0
                        self.Email_TF.layer.borderColor = errorColour.cgColor
                    }
                    // Should only return one document but this is how it needs to be written
                    for document in querySnapshot!.documents {
                        print(document.data().count)
                        if let doc = document.data() as? [String: Any] {
                            let passwordString = doc["Password"] as! String
                            print(Password)
                            print(passwordString)
                            
                            if (passwordString != Password){
                                print("Password doesn't match")
                                self.IncorrectMessage.text! = "Incorrect Password"
                                result = false
                                print(result)
                                self.IncorrectMessage.isHidden = false
                                self.Password_TF.layer.borderWidth = 1.0
                                self.Password_TF.layer.borderColor = errorColour.cgColor
                            }
                            else {
                                let role = doc["Role"] as! String
                                UserDefaults.standard.set(Email, forKey:"userId");
                                UserDefaults.standard.set(role, forKey:"userRole");
                                UserDefaults.standard.synchronize()
                                Auth.auth().signIn(withEmail: Email, password: Password) { authResult, error in
                                    if let error = error {
                                        print(error)
                                    }
                                    else{
                                        self.performSegue(withIdentifier: "toStaffMenu", sender: self)
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    
    @IBAction func Login_BTN(_ sender: Any) {
            self.errorChecking(Email: Email_TF.text!, Password: Password_TF.text!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        IncorrectMessage.isHidden = true
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
