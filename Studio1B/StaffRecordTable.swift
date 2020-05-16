//
//  StaffRecordTable.swift
//  Studio1B
//
//  Created by Gabrielle Walker on 3/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class StaffRecordTable: StaffMenu, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    @IBOutlet weak var CreateNew_BTN: UIButton!
    let staffRole = UserDefaults.standard.object(forKey: "userRole") as! String
    let userId = UserDefaults.standard.object(forKey: "userId") as! String

    @IBAction func createNew_BTN(_ sender: Any) {
        performSegue(withIdentifier: "createNewStaffRecordSegue", sender: self)
    }

    var staff = [Any]()

    func getData() {
        db.collection("Staff").getDocuments() {
            (querySnapshot, err) in if let err = err {
                print("Firebase Error")
            }
            else{
                for document in querySnapshot!.documents{
                    var a = document.data()
                    self.staff.append(a)
                }
                self.tableView.reloadData()
            }
        }
    }

    func deleteRecord(RecordID: String) {
        db.collection("Staff").document(RecordID).delete() {
            err in if let err = err {
                print("Error deleting document")
            }
            else{
                print("Document deleted")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if (staffRole != "RestaurantManager") {
            CreateNew_BTN.isEnabled = false
            CreateNew_BTN.backgroundColor = UIColor.gray
        }
        // Do any additional setup after loading the view.
        self.getData()
    }


    var staffRecord = [String: Any]()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditStaff {
            vc.staff = staffRecord
       }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let staffRec = self.staff[indexPath.row] as? [String: Any]{
            staffRecord = staffRec
        }
        if (staffRole == "RestaurantManager") || (staffRecord["Email"] as! String == userId) {
            self.performSegue(withIdentifier: "toEditStaff", sender: self)
        }
        else{
            print(staffRole)
            print(userId)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.staff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StaffCell
        
        print(self.staff)

        if let staffMember = self.staff[indexPath.row] as? [String: Any] {
            let staffFirst = staffMember["FirstName"] as! String
            let staffLast = staffMember["LastName"] as! String
            let staffRole = staffMember["Role"] as! String

            cell.staffFirst?.text = staffFirst
            cell.staffLast?.text = staffLast
            cell.staffRole?.text = staffRole
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) && (staffRole == "RestaurantManager") {
            
            if let staffMember = self.staff[indexPath.row] as? [String: Any] {
                var first = staffMember["FirstName"] as! String
                var last = staffMember["LastName"] as! String
                var staffID = first + " " + last
                self.deleteRecord(RecordID: staffID)
            }
            
            staff.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }

}

