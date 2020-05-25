//
//  MealOrderingOne.swift
//  Studio1B
//
//  Created by David Bolis on 15/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class MealOrderingOne: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var CompletOutlet: UIButton!
    public var Mainsmenu:[String]  = []
    public var Dessertsmenu:[String]  = []
    public var Drinksmenu:[String]  = []
    public var mealcount:[Int]  = []
    public var bookingSelected = ""
    @IBOutlet weak var BookingPicker: UIPickerView!
    public var Bookings: [String] = ["Please Select a Booking"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetMeals()
        TableViewMenu.reloadData()
        BookingPicker.reloadAllComponents()
        
    }
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
       }
       
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Bookings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Bookings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       bookingSelected = Bookings[row]
       
    }
    
    @IBOutlet weak var TableViewMenu: UITableView!
    func GetMeals(){
        let db = Firestore.firestore()
        let User = Auth.auth().currentUser!.email!
        db.collection("Menu").addSnapshotListener { (snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                
                
                let Meals = i.document.documentID
                
                DispatchQueue.main.async {
                   
                    self.Mainsmenu.append(Meals)
                    self.TableViewMenu.reloadData()
                    
                    
                    
                }
            }
        }
       
        db.collection("Booking").whereField("CustomerID", isEqualTo: "\(User)").addSnapshotListener { (snap, err) in
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
            for i in snap!.documentChanges{
                let BookingID = i.document.get("BookingID") as! String
                self.Bookings.append(BookingID)
                self.BookingPicker.reloadAllComponents()
               
            }
        }
    }
        
        
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(Mainsmenu.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let Maincell = tableView.dequeueReusableCell(withIdentifier: "Mains") as! MealOrderingTableViewCell
        Maincell.MenuItemsLabel.text = Mainsmenu[indexPath.row]
        Maincell.MinusBtn.tag = indexPath.row
        Maincell.AddButton.tag = indexPath.row
        Maincell.AddButton.addTarget(self, action: #selector(AddtoCount(sender:)), for: .touchDown)
        Maincell.MinusBtn.addTarget(self, action: #selector(RemovetoCount(sender:)), for: .touchDown)
        for ii in Mainsmenu{
            mealcount.append(0)
        }
        Maincell.MealCountLabel.text = "\(mealcount[indexPath.row])"
       

        return(Maincell)
    }
    @objc
    func AddtoCount(sender:UIButton){
        let rowIndex:Int = sender.tag
         mealcount[rowIndex] += 1
        TableViewMenu.reloadData()
        
    }
    @objc
    func RemovetoCount(sender:UIButton){
         let rowIndex:Int = sender.tag
        mealcount[rowIndex] -= 1
        TableViewMenu.reloadData()
        
    }
    
    
    @IBAction func CompleteOrderButton(_ sender: Any) {
 
        let vc = self.storyboard?.instantiateViewController(identifier: "MealOrderingTwo") as! MealOrderingtwo
       
        for Numbers in mealcount{
         
         
            if Numbers > 0 {
                var i = mealcount.firstIndex(of: Numbers)
                vc.QTN.append(Numbers)
                vc.MealsOrdered.append(Mainsmenu[i!])
                vc.BookingID = bookingSelected
            }
        }
        
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
   
    
    
    
}
