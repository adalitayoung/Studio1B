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
                }
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
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.generateTableData()
        self.getData()
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderListCell
        
        print(indexPath)
        if let orderItem = self.items[indexPath.row] as? [String: Any] {
            cell.itemName?.text = items["Meal"]
            cell.itemQty?.text = items["Quantity"]
        }

        return cell
    }

}
