//
//  MealOrderingtwo.swift
//  Studio1B
//
//  Created by David Bolis on 15/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase
class MealOrderingtwo: UIViewController,  UITableViewDelegate, UITableViewDataSource  {
    let CurrentUserId = Auth.auth().currentUser?.uid
    var MealsOrdered: [String] = []
    var BookingID = ""
    public var Timeordered = Date()
    public var TimeToServe = ""
    var QTN: [Int] = []
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var CustomerEmail: UILabel!
    @IBOutlet weak var CustomerMobile: UILabel!
    @IBOutlet weak var CustomerName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetUser()
        TableView.reloadData()
        print(MealsOrdered)
        
    }
    @IBAction func BackTem(_ sender: Any) {
        dismiss(animated: false)
    }
    
    func GetUser(){
        let db = Firestore.firestore()
        db.collection("Customer").whereField("CustomerUID", isEqualTo: "\(CurrentUserId!)").addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                
                
                let CustomerFirst = i.document.get("FirstName")
                let Customerlast = i.document.get("LastName")
                let CustomerMobilee = i.document.get("Mobile")
                let Customeremail = i.document.get("Email")
                DispatchQueue.main.async {
                    self.CustomerName.text = "\(CustomerFirst!), \(Customerlast!)"
                    self.CustomerMobile.text = "\(CustomerMobilee!)"
                    self.CustomerEmail.text = "\(Customeremail!)"
                    
                }
            }
        }
        db.collection("Booking").whereField("BookingID", isEqualTo: "\(BookingID)").addSnapshotListener { (snap, err) in
             if err != nil{
                 print((err?.localizedDescription)!)
                 return
             }
                 for i in snap!.documentChanges{
                 let TimePreferred = i.document.get("Preferred Time") as! Timestamp
                    self.Timeordered =  TimePreferred.dateValue()
                    self.Timeordered = self.Timeordered + 10
                    self.TimeToServe = "\(self.Timeordered)"
                  
                   
                    
                 }
             }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(MealsOrdered.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let Maincell = tableView.dequeueReusableCell(withIdentifier: "Meals") as! OrderConfirmation
        Maincell.MealOrdered.text = MealsOrdered[indexPath.row]
        Maincell.QTN.text = String(QTN[indexPath.row])
        
        return(Maincell)
    }
    
    @IBAction func ConfirmOrderBTN(_ sender: Any) {
        let date = Date()
        let calender = Calendar.current
//        let hour = calender.component(.hour, from: date)
//        let Minute = calender.component(.minute, from: date)
//        let Day = calender.component(.day, from: date)
//        let month = calender.component(.month, from: date)
//        let year = calender.component(.year, from: date)
//        let second = calender.component(.second, from: date)
        let UserID = Auth.auth().currentUser!.email
        let db = Firestore.firestore()
        let timestamp = Timestamp(date: date)
        let TimeToServe = Timestamp(date: calender.date(byAdding: .minute, value: 30, to: date)!)

        db.collection("Order").document().setData(["CustomerID": UserID as Any, "CustomerMeals": MealsOrdered, "MealQTN": QTN, "TimeCreated": timestamp, "BookingID": "B1", "DiscountID": "Loyal Customers", "TimeToServe" : TimeToServe ]){ (err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
        }
        
       
        
        
        CreatAlert(title: "Order Confirmed", MSG: "Your Order Will Be Ready For You When You Arrive")
        
        
    }
    
    @IBAction func CancelOrder(_ sender: Any) {
        CreatAlert(title: "Order Canceled", MSG: "Your Order Has Been Canceled!")
        
    }
    
    func CreatAlert(title:String, MSG: String){
        let alert = UIAlertController(title: title, message: MSG, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (Action) in
            alert.dismiss(animated: true, completion: nil)
            let vc = self.storyboard?.instantiateViewController(identifier: "OurMenuGrid") as! ViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
