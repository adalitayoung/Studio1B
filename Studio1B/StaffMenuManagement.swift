//
//  StaffMenuManagement.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 11/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//
import Firebase
import UIKit

class StaffMenuManagement: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentMenu: String = "Lunch"
    var priceAsc: Bool = true
    
    @IBOutlet weak var lunch_btn: UIButton!
    @IBOutlet weak var dinner_btn: UIButton!
    @IBOutlet weak var dessert_btn: UIButton!
    @IBOutlet weak var drinks_btn: UIButton!

    @IBAction func lunch_btn(_ sender: Any) {
        currentMenu = "Lunch"
        self.getData(Type: currentMenu)
    }

    @IBAction func dinner_btn(_ sender: Any) {
        currentMenu = "Dinner"
        self.getData(Type: currentMenu)
    }
    @IBAction func dessert_btn(_ sender: Any) {
        currentMenu = "Desserts"
        self.getData(Type: currentMenu)
    }
    @IBAction func drinks_btn(_ sender: Any) {
        currentMenu = "Drinks"
        self.getData(Type: currentMenu)
    }
    
    @IBAction func createNewItem_btn(_ sender: Any) {
        performSegue(withIdentifier: "createNewItem", sender: self)
    }
    var ActiveItems = [Any]()
            var Dinner = [Any]()
            var Dessert = [Any]()
            var Drinks = [Any]()
        
            func getData(Type: String) {
                var menuName = Type
                var pricingOption = ""
                if (Type == "Lunch"){
                    menuName = "Dinner"
                }
                if (Type != "Lunch" && Type != "Dinner") {
                    pricingOption = "Dinner"
                }
                else {
                    pricingOption = Type
                }
                
                self.ActiveItems = [Any]()
                db.collection("Menu").whereField("Type", isEqualTo: menuName).getDocuments() {
                    (querySnapshot, err) in
                    if let err = err {
                        print ("Error")
                    }
                    else {
                        print("!!")
                        for document in querySnapshot!.documents{
                            var a = document.data()
                            var temp = pricingOption+" Price"
                            a["Price"] = a[temp]
                            a["Name"] = document.documentID
                            self.ActiveItems.append(a)
                        }
                        self.tableView.reloadData()
        
                    }
        
                    switch menuName{
                        case "Lunch","Dinner":
                            self.Dinner = self.ActiveItems
                        case "Desserts":
                            self.Dessert = self.ActiveItems
                        case "Drinks":
                            self.Drinks = self.ActiveItems
                        default:
                            print("Error selecting menu")
                    }
                    
                }
            }
        
            override func viewDidLoad() {
                super.viewDidLoad()
                lunch_btn.layer.borderWidth = 1
                lunch_btn.layer.borderColor = UIColor.black.cgColor
                dinner_btn.layer.borderWidth = 1
                dinner_btn.layer.borderColor = UIColor.black.cgColor
                dessert_btn.layer.borderWidth = 1
                dessert_btn.layer.borderColor = UIColor.black.cgColor
                drinks_btn.layer.borderWidth = 1
                drinks_btn.layer.borderColor = UIColor.black.cgColor
                tableView.delegate = self
                tableView.dataSource = self
                // Do any additional setup after loading the view.
                self.getData(Type: currentMenu)
            }
            
            var menuItem = [String: Any]()
        
                
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Determine what the segue destination is

               if let vc = segue.destination as? EditMenuItem {
                   vc.menuItem = menuItem
               }
            }
        
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                print("you tapped me!")
                        
                if let item = self.ActiveItems[indexPath.row] as? [String: Any]{
                    menuItem = item
                }
                self.performSegue(withIdentifier: "toViewMenuItem", sender: self)
                
            }
             
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return self.ActiveItems.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodCell
                
                //set cell text as discount ids
                if let foodItem = self.ActiveItems[indexPath.row] as? [String: Any] {
                    let foodItemToLoad = foodItem["Name"] as! String
                    let foodPriceToLoad = foodItem["Price"] as! Double
                    cell.foodName?.text = foodItemToLoad
                    cell.foodPrice?.text = "$" + String(foodPriceToLoad)
                }
                return cell
            }
        }
        
        
