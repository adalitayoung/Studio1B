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
    @IBAction func createNew_BTN(_ sender: Any) {
        performSegue(withIdentifier: "createNewSegue", sender: self)
    }
    
    @IBAction func delete_BTN(_ sender: Any) {
        
    }
    
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
                    var a = document.data()
                    a["Name"] = document.documentID
                    self.discounts.append(a)
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
    }

}

extension DicountTable: UITableViewDelegate {
    
    func deleteRecord(RecordID: String) {
        db.collection("Rewards").document(RecordID).delete() {
            err in
                if let err = err {
                    print("Error deleting document")
                }
                else {
                    print("Document successfully deleted")
                }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
        
        var discountDescription = ""
        
        if let discount = self.discounts[indexPath.row] as? [String: Any] {
            discountDescription = discount["Description"] as! String
        }
        
        let alert = UIAlertController(title: "Discount Discription",
                                            message: discountDescription,
                                            preferredStyle: .alert)
        
        // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    

}

extension DicountTable: UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.discounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DiscountCell
        
        print(self.discounts)
        //set cell text as discount ids
        if let discount = self.discounts[indexPath.row] as? [String: Any] {
            let discountToLoad = discount["Name"] as! String
            let discountValueToLoad = discount["Deduction"] as! Double
            cell.discountName?.text = discountToLoad
            cell.discountValue?.text = String(discountValueToLoad)
        }
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            if let discount = self.discounts[indexPath.row] as? [String: Any] {
                var discountName = ""
                discountName = discount["Name"] as! String
                self.deleteRecord(RecordID: discountName)
            }
            
            discounts.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }
}
