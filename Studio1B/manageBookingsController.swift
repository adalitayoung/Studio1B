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
   
    

    var bookingTable = [Bookings]()
    let db = Firestore.firestore()
    
    @IBOutlet weak var Tableview: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        ref = Database.database().reference().child("Booking")
//
//        ref.observe(DataEventType.value, with: {(snapshot)}); in
//        if snapshot.childrenCount > 0 {
//            self.bookingTable.removeAll()
//
//            for booking in snapshot.children.allObjects as! [DataSnapshot] {
//                let Object = booking.value as?[String: AnyObject]
//                let BookingID = Object?["BookingID"]
//                let NumberOfGuests = Object?["People"]
//                let PreferredTime = Object?["Preferred Time"]
//                let CustomerID = Object?["CustomerID"]
//
//                let booking = Bookings(bookingID: BookingID as! String, numberOfGuests: NumberOfGuests as! Int, preferredTime: PreferredTime as! String, customerID: CustomerID as! String)
//                self.bookingTable.append(booking)
//                self.Tableview.reloadData()
//            }
//
//        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingTable.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Tableview.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let booking: Bookings
        
        booking = bookingTable[indexPath.row]
        cell.bookingIDLabel.text = booking.bookingID
        
        return cell
        
    }
    
    //from video not sure if applicable
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        guard let videoURL = URL(string: table[indexPath.row].link) else {
//            return
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
