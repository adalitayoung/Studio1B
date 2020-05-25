//
//  menuController.swift
//  Studio1B
//
//  Created by Sam Zammit on 28/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class menuController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func GetInfo(){
        //First we create a reference to the database, i will use db for short...
        let db = Firestore.firestore() //This will be our reference
        //Now we will start looking into a collection in the database, in this example my collection is called "Users"
        db.collection("Menu").getDocuments{ (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            //line 23 to 25 is only there for error handling
            for i in snap!.documents{ //This line will make you go throughout the entire database.
                if i.documentID == "Dinner"{ //This line will let only show you the data for the current USer using the app, this is usefill in some cases.
                    //removing line 29 will mean that you will be able to request all the data on the database, and not just that belonging to the user (Could be dangerous but useful in some scenarios, for example requesting menu items. )
//                    let Items = i.get() as! String  // Now we successfully retreived the username of the current User
                    print(i.documentID)
                }
                
            }
        }
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
