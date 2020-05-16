//
//  DiscountTableViewController.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 24/4/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class DicountTable: StaffMenu, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    @IBAction func createNew_BTN(_ sender: Any) {
        performSegue(withIdentifier: "createNewSegue", sender: self)
    }
    
    @IBOutlet weak var createNew_BTN: UIButton!
    @IBAction func delete_BTN(_ sender: Any) {
        
    }
    
    var discounts = [Any]()
    let staffRole = UserDefaults.standard.object(forKey: "userRole") as! String

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
        if (staffRole != "RestaurantManager") {
            createNew_BTN.isEnabled = false
            createNew_BTN.backgroundColor = UIColor.gray
        }
        // Do any additional setup after loading the view.
        self.getData()
    }
    
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
    
    var discountName = ""
    var discountDescription = ""
    var discountValue = 0.0
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Determine what the segue destination is
        
        if let vc = segue.destination as? EditDiscount {
            vc.discountName = discountName
            vc.discountDescription = discountDescription
            vc.discountValue = discountValue
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
                
        if let discount = self.discounts[indexPath.row] as? [String: Any] {
            discountDescription = discount["Description"] as! String
            discountName = discount["Name"] as! String
            discountValue = discount["Deduction"] as! Double
        }
        
        let alert = UIAlertController(title: "Discount Discription",
                                            message: discountDescription,
                                            preferredStyle: .alert)
        
        // Add action buttons to it and attach handler functions if you want to
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Edit Discount", style: .destructive, handler: { action in
            self.performSegue(withIdentifier: "toEditDiscount", sender: self)
        }))
        self.present(alert, animated: true)
    }
     
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
        if (editingStyle == UITableViewCell.EditingStyle.delete) && (staffRole == "RestaurantManager"){
            
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
