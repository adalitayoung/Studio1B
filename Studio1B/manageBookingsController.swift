//
//  manageBookingsController.swift
//  Studio1B
//
//  Created by Sam Zammit on 7/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import AVKit

class manageBookingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var bookings = [Any]()
    let db = Firestore.firestore()
    var userEmail = ""

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
        
    
    func getData(){
        db.collection("Booking").whereField("CustomerID", isEqualTo: userEmail).getDocuments(){
            (querySnapshot, err) in if let err = err{
                print("Firebase Error")
            }
            else{
                for document in querySnapshot!.documents{
                    var a = document.data()
                    self.bookings.append(a)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func deleteBooking(BookingID: String){
        db.collection("Booking").document(BookingID).delete(){
            err in if let err = err{
                print("Could not Delete Booking")
            }
            else{
                print("Booking Deleted")
            }
        }
    }
    
    override func viewDidLoad() {
        let user = Auth.auth().currentUser
        if let user = user {
            userEmail = user.email as! String
            //self.Email_TF?.text = userEmail
        }
    
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.getData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookings.count
    }

    var bookingRecord = [String: Any]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditBooking {
            vc.booking = bookingRecord
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let bookingRec = self.bookings[indexPath.row] as? [String: Any]{
            bookingRecord = bookingRec
        }
        self.performSegue(withIdentifier: "toEditBooking", sender: self)
    }
    
    func deleteRecord(RecordID: String){
        db.collection("Booking").document(RecordID).delete() {
            err in if let err = err {
                print(err)
            }
            else{
                print("Document deleted")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            if let booking = self.bookings[indexPath.row] as? [String: Any] {
                let bookingID = booking["BookingID"] as! String
                self.deleteRecord(RecordID: bookingID)
            }
            
            bookings.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bookingCell
        
        //set cell text as discount ids
            if let madeBooking = self.bookings[indexPath.row] as? [String: Any] {
                let bookingGuests = madeBooking["People"] as! String
                let date = NSDate(timeIntervalSince1970: TimeInterval((madeBooking["Preferred Time"] as! Timestamp).seconds))
                let formatter = DateFormatter()
                formatter.dateFormat = "d/MM/y; HH:mm"
                var timeString = formatter.string(from: date as Date)
                cell.noOfGuests?.text = bookingGuests
                cell.time?.text = timeString
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
