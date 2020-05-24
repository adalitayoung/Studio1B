//
//  OrderList.swift
//  Studio1B
//
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

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
                    let date = NSDate(timeIntervalSince1970:TimeInterval((a["TimeToServe"] as! Timestamp).seconds))
                    let isToday = Calendar.current.isDateInToday(date as Date)
                    if (isToday){
                        a["DocumentID"] = document.documentID
                        self.orders.append(a)
                    }
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


    var orderRecord = [String: Any]()
    var orderNumber = 0;

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewOrder {
            vc.order = orderRecord
            vc.orderNo = String(orderNumber)
       }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let orderRec = self.orders[indexPath.row] as? [String: Any]{
            orderRecord = orderRec
        }
        if let orderNo = (indexPath.row+1) as? Int{
            orderNumber = orderNo
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
            let orderNumber = String(indexPath.row+1)
            
            cell.orderNumber?.text = orderNumber
            print(indexPath.row+1)
            var itemQty = 0;
            let itemArray = orderItem["MealQTN"] as! [Any]
            for i in itemArray {
                print(i)
                itemQty+=i as! Int
            }
            print(itemQty)
            cell.itemQty?.text = String(itemQty)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let date = NSDate(timeIntervalSince1970:TimeInterval((orderItem["TimeToServe"] as! Timestamp).seconds))
            let dateString = formatter.string(from: date as Date)
            cell.TimeToServe?.text = dateString
            let orderStatus = orderItem["OrderCompleted"]
            if (orderStatus as! Bool) {
                cell.orderStatus.image = UIImage(named: "green_tick")
            }
            
        }

        return cell
    }
    
}
