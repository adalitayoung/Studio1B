//
//  ViewInvoice.swift
//  Studio1B
//
//  Created by Adalita Young on 22/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class ViewInvoice: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var order = [String: Any]()
    var menu = [Any]()
    var items = [Any]()
    let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    
    func getMenu() {
        db.collection("Menu").getDocuments(){(querySnapshot, error) in
            if let error = error{
                print(error)
            }
            else {
                for document in querySnapshot!.documents{
                    self.menu.append(document.data())
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(self.order)
        self.getMenu()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecificInvoiceTableCell
        
        print(indexPath)
        if let orderItem = self.items[indexPath.row] as? [String: Any] {
//            cell.itemQty?.text = orderItem["Qty"] as! String
//            cell.itemName?.text = orderItem["ItemName"] as! String
//            cell.itemCost?.text = "$"+(orderItem["Cost"] as! String)
            
            
        }

        return cell
    }

}
