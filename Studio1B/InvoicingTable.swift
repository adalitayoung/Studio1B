//
//  InvoicingTable.swift
//  Studio1B
//
//  Created by Adalita Young on 21/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class InvoicingTable: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var orders = [Any]()
    let db = Firestore.firestore()
    
    
    func getData() {
        db.collection("Order").order(by:"TimeCreated",descending: false).getDocuments(){
            (querySnapshot, err) in if let err = err {
                print("Firebase Error")
            }
            else{
//                Move this to outside
                let user = Auth.auth().currentUser;
                if let user = user {
                    let email = user.email as! String
                    var userID = ""
                    self.db.collection("Customer").whereField("Email", isEqualTo: email).getDocuments(){
                        (querySnapshot, error) in
                        if let error = error {
                            print(error)
                        }
                        else{
                            for document in querySnapshot!.documents{
                                userID = document.data()["CustomerUID"] as! String
                                print(userID)
                            }
                        }
                    }
                    for document in querySnapshot!.documents{
                        var a = document.data()
                        if (a["CustomerID"] as! String == userID){
                            a["DocumentID"] = document.documentID
                            self.orders.append(a)
                        }
                        else{
                            print(a)
                        }
                    }
                    self.tableView.reloadData()
                }
                else{
                    print("User Not logged in")
                }
                
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


    var orderRecord = [String: Any]()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? ViewOrder {
//            vc.order = orderRecord
//       }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let orderRec = self.orders[indexPath.row] as? [String: Any]{
            orderRecord = orderRec
        }
//        self.performSegue(withIdentifier: "toViewOrder", sender: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InvoiceTableCell
        
        print(indexPath)
        if let orderItem = self.orders[indexPath.row] as? [String: Any] {
//            let orderNumber = String(indexPath.row+1)
//
//            cell.orderNumber?.text = orderNumber
//            print(indexPath.row+1)
//            var itemQty = 0;
//            let itemArray = orderItem["MealQTN"] as! [Any]
//            for i in itemArray {
//                print(i)
//                itemQty+=i as! Int
//            }
//            print(itemQty)
//            cell.itemQty?.text = String(itemQty)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let date = NSDate(timeIntervalSince1970:TimeInterval((orderItem["TimeCreated"] as! Timestamp).seconds))
            let dateString = formatter.string(from: date as Date)
            cell.TimeCreated?.text = dateString
            let isPaid = orderItem["Paid"] as? Bool
            var isPaidString = ""
            if (isPaid != nil){
                isPaidString = "Not Paid"
            }
            else{
                isPaidString = "Paid"
            }
            cell.isPaid?.text = isPaidString
            
        }

        return cell
    }
    

}
