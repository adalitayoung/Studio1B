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
    

    // store firebase discount names as array
  //  let discounts = db.data()!["Rewards"] as! [String] ??????

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension DicountTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}

extension DicountTable: UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
        // return number of objects in array
        //return discounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "hello"
        
        //set cell text as discount ids
        
        //cell.textLabel?.text = discounts[indexPath.row]
        
        return cell
        
        
    }
    
    
    
}
