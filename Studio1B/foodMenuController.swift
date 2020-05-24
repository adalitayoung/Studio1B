//
//  foodMenuController.swift
//  Studio1B
//
//  Created by Sam Zammit on 28/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class foodMenuController: UIViewController {

    var Dinner :  [Any] = []
    var Drinks :  [Any] = []
    var Desserts :  [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetInfo()
        // Do any additional setup after loading the view.
    }
    
    
    func GetInfo(){
        
            //First we create a reference to the database, i will use db for short...
            let db = Firestore.firestore() //This will be our reference
            //Now we will start looking into a collection in the database, in this example my collection is called "Users"
            db.collection("Menu").addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                if i.type == .added{
                    let item = i.document.get("Type") as! String
               
                    if item == "Dinner"{
                        let items = i.document.data()
                        self.Dinner.append(items)
                    }
                    if item == "Drinks"{
                        let items = i.document.data()
                        self.Drinks.append(items)
                    }
                    if item == "Desserts"{
                        let items = i.document.data()
                        self.Desserts.append(items)
                    }
                }
            }
                print(self.Drinks)
                print(self.Dinner)
                print(self.Desserts)
        }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return modelObjectsArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
//        let modelObject = self.modelObjectsArray[indexPath.row] as! foodItem
//        cell.textLabel?.text = modelObject.firstname
//        return cell
//    }
//
    
}


