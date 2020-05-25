//
//  specificBookingController.swift
//  Studio1B
//
//  Created by Sam Zammit on 22/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import AVKit


class specificBookingController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var specificBooking = [Any]()
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    
    func getData(){
        db.collection("Booking").getDocuments(){
            (querySnapshot, err) in if let err = err{
                print("Firebase Error")
            }
            else{
                for document in querySnapshot!.documents{
                    var a = document.data()
                    self.specificBooking.append(a)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.getData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.specificBooking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specific booking cell", for: indexPath) as! specificBookingCell
        if let currentBooking = self.specificBooking[indexPath.row] as? [String: Any]{
            let bookingFirstName = currentBooking["FirstName"] as! String
            let bookingLastName = currentBooking["LastName"] as! String
            let bookingEmail = currentBooking["Email Address"] as! String
            let bookingCustomerID = currentBooking["CustomerID"] as! String
            let bookingGuests = currentBooking["People"] as! Int
            let bookingNumber = currentBooking["Contact Number"] as! Int
            let bookingMessage = currentBooking["Special Considerations"] as! String
            let date = NSDate(timeIntervalSince1970: TimeInterval((currentBooking["Preferred Time"] as! Timestamp).seconds))
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM y,HH:mm"
            var timeString = formatter.string(from: date as Date)
            cell.firstNameEdit?.text = bookingFirstName
            cell.lastNameEdit?.text = bookingLastName
            cell.emailEdit?.text = bookingEmail
            cell.timeEdit?.text = timeString
            cell.guestsEdit?.text = String(bookingNumber)
            cell.messageEdit?.text = bookingMessage
            cell.customerIDEdit?.text = bookingCustomerID
            
        }
        return cell
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
