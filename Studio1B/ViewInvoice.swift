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
    var discounts = [Any]()
    let db = Firestore.firestore()
    var timeOfDay = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var discountName: UILabel!
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var discountToUseLabel: UILabel!
    @IBOutlet weak var totalBeforeDiscount: UILabel!
    @IBOutlet weak var totalAfterDiscount: UILabel!
    @IBOutlet weak var totalSavingsLabel: UILabel!
    @IBOutlet weak var totalSavings: UILabel!
    
    func calculateTotals(){
        let discount = order["DiscountID"] as? String
        var discountName = ""
        var discountValue = 0.0
        print(self.discounts)
        for i in 0..<self.discounts.count{
            if let discountDocument = self.discounts[i] as? [String:Any]{
                if (discount == discountDocument["DiscountName"] as! String){
                    discountName = discountDocument["DiscountName"] as! String
                    self.discountName?.text = discountName
                    discountValue = discountDocument["Deduction"] as! Double
                    self.discountValue?.text = String(discountValue)
                }
            }
        }
        var total = 0.0
        for item in self.items{
            if let itemDocument = item as? [String: Any] {
                total += (Double(itemDocument["Price"] as! Int) * Double(itemDocument["Qty"] as! Int))
            }
        }
        self.totalBeforeDiscount?.text = String(format:"%.2f", total)
        
        if (discountValue != 0) {
            var deduction = total * discountValue
            self.totalSavings?.text = String(format:"%.2f", deduction)
            var totalPostDiscount = total - deduction
            self.totalAfterDiscount?.text = String(format:"%.2f", totalPostDiscount)
        }
        else {
            self.totalSavings?.isHidden = true
            self.totalSavingsLabel?.isHidden = true
            self.discountName?.isHidden = true
            self.discountValue?.isHidden = true
            self.discountToUseLabel?.isHidden = true
            self.totalAfterDiscount?.text = String(format:"%.2f", total)
        }
    }
    
    func generateTableData(){
        let mealItems = order["CustomerMeals"] as! [Any]
        let mealQtys = order["MealQTN"] as! [Any]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss d MMM yyyy"
        let date = NSDate(timeIntervalSince1970:TimeInterval((order["TimeToServe"] as! Timestamp).seconds))

        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour], from: date as Date)
        
        if (components.hour! < 17){
            self.timeOfDay = "Lunch"
        }
        else{
            self.timeOfDay = "Dinner"
        }
                
        for i in 0..<mealItems.count{
            for j in 0..<menu.count{
                if let menuDocument = menu[j] as? [String: Any]{
                    if (menuDocument["ItemName"] as! String == mealItems[i] as! String) {
                        if (self.timeOfDay == "Lunch"){
                            self.items.append(["Meal": mealItems[i],"Qty": mealQtys[i], "Price": menuDocument["Lunch Price"] as! Int])
                        }
                        else{
                            self.items.append(["Meal": mealItems[i],"Qty": mealQtys[i], "Price": menuDocument["Dinner Price"] as! Int])
                        }
                    }
                }
            }
        }
        self.tableView.reloadData()
        self.calculateTotals()
    }
    
    func getMenu() {
        db.collection("Rewards").getDocuments{(querySnapshot, error) in
            if let error = error {
                print(error)
            }
            else{
                for document in querySnapshot!.documents{
                    var a = document.data()
                    a["DiscountName"] = document.documentID
                    self.discounts.append(a)
                }
                print(self.discounts)
                self.db.collection("Menu").getDocuments(){(querySnapshot, error) in
                    if let error = error{
                        print(error)
                    }
                    else {
                        for document in querySnapshot!.documents{
                            var a = document.data()
                            a["ItemName"] = document.documentID
                            self.menu.append(a)
                        }
                        self.generateTableData()
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
            print(orderItem)
            cell.itemQty?.text = String(orderItem["Qty"] as! Int)
            cell.itemName?.text = (orderItem["Meal"] as! String)
            cell.itemCost?.text = "$" + String(orderItem["Price"] as! Int)
        }

        return cell
    }

}
