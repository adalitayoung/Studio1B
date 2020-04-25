//
//  DiscountTableViewController.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 24/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class DicountTable: StaffMenu {
    
    @IBOutlet var tableView: UITableView!
    
    var discounts = [Any]()

    func getData() {

        db.collection("Rewards").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print ("Error")
            }
            else {
                print("!!")
                for document in querySnapshot!.documents{
//                    print(document.data())
//                    print(document.documentID)
                    var a = document.data()
                    a["Name"] = document.documentID
                    self.discounts.append(a)
                    //print(self.discounts)
                }
                self.tableView.reloadData()

            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        self.getData()
//        print(discounts)
    }

}

extension DicountTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}

extension DicountTable: UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return number of objects in array
       // print(self.discounts.count)
        return self.discounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        print(self.discounts)
        //set cell text as discount ids
        if let discount = self.discounts[indexPath.row] as? [String: Any] {
            var discountToLoad = discount["Name"] as! String
            cell.textLabel?.text = discountToLoad
        }
        return cell
    }
    
    
    
}
