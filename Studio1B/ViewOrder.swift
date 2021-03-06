//
//  ViewOrder.swift
//  Studio1B
//
//  Created by Adalita Young on 18/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class ViewOrder: StaffMenu, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    var orderNo = "";
    var orderCompleted = false;

    var items = [Any]()
    var order = [String:Any]()
    var booking = [String:Any]()
    
    func getData(){
        db.collection("Booking").whereField("BookingID", isEqualTo: order["BookingID"]).getDocuments() {(querySnapshot, err) in
            if let err = err {
                print(err)
            } else{
                for document in querySnapshot!.documents {
                    self.booking = document.data()
                    print(document.data())
                }
                if (self.order["OrderCompleted"] != nil && self.order["OrderCompleted"] as! Bool) {
                    self.orderCompleted = true
                    print(self.orderCompleted)
                    self.orderStatus.setOn(true, animated: true)
                }
                self.tableNumber.text! = String(self.booking["Table Number"] as! Int) //as! String
            }
        }
    }
    
    func generateTableData(){
        let mealItems = order["CustomerMeals"] as! [Any]
        let mealQtys = order["MealQTN"] as! [Any]
        for i in 0..<mealItems.count{
            items.append(["Meal": mealItems[i],"Quantity": mealQtys[i]])
        }
    }
    
    func updateOrder(switchStatus: Bool) {
        db.collection("Order").document(self.order["DocumentID"] as! String).updateData(["OrderCompleted": switchStatus]) {err in
            if let err = err {
                print(err)
            }
            else{
                print("Status updated")
                print(switchStatus)
                self.performSegue(withIdentifier: "orderComplete", sender: self)
            }
        }
    }
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var tableNumber: UILabel!
    
    @IBOutlet weak var orderStatus: UISwitch!
    
    @IBAction func completeOrder(_ sender: UISwitch) {
        var switchStatus:Bool = false
        if (!orderCompleted) {
            switchStatus = sender.isOn
            updateOrder(switchStatus: switchStatus)
        }
        else {
            updateOrder(switchStatus: switchStatus)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.generateTableData()
        self.getData()
        // Do any additional setup after loading the view.
        orderNumber.text! = orderNo
        print(orderNo)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderDetailCell
        
        print(indexPath)
        if let orderItem = self.items[indexPath.row] as? [String: Any] {
            cell.itemName?.text = orderItem["Meal"] as! String

            let quantity = orderItem["Quantity"] as! Int
            
            cell.itemQty?.text = String(quantity)
        }

        return cell
    }

}
