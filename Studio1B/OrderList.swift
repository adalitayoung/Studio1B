//
//  OrderList.swift
//  Studio1B
//
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class OrderList: StaffMenu, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    var orders = [Any]()

    func getData() {
        db.collection("Order").order(by:"TimeToServe",descending: false).getDocuments(){
            (querySnapshot, err) in if let err = err {
                print("Firebase Error")
            }
            else{
                for document in querySnapshot!.documents{
                    var a = document.data()
                    self.orders.append(a)
                }
                print(self.orders)
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


    var orderRecord = [String: Any]()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewOrder {
            vc.order = orderRecord
       }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let orderRec = self.orders[indexPath.row] as? [String: Any]{
            orderRecord = orderRec
        }
        self.performSegue(withIdentifier: "toViewOrder", sender: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderListCell
        
        print(indexPath)
        if let orderItem = self.orders[indexPath.row] as? [String: Any] {
//            let staffFirst = orderItem["FirstName"] as! String
//            let staffLast = orderItem["LastName"] as! String
//            let staffRole = orderItem["Role"] as! String
//
//            cell.staffFirst?.text = staffFirst
//            cell.staffLast?.text = staffLast
//            cell.staffRole?.text = staffRole
        }

        return cell
    }
    
}
