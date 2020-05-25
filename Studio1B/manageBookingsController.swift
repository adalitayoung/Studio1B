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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var viewBtn: UIButton!
    
    //let bookingEmail = UserDefaults.standard.object(forKey: "Email") as! String
    
    
    func getData(){
        db.collection("Booking").getDocuments(){
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
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.getData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookings.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bookingCell
        
        //set cell text as discount ids
            if let madeBooking = self.bookings[indexPath.row] as? [String: Any] {
                let bookingFirstName = madeBooking["FirstName"] as! String
                let bookingLastName = madeBooking["LastName"] as! String
                let bookingFullName = bookingFirstName + " " + bookingLastName
                let bookingEmail = madeBooking["Email Address"] as! String
                let bookingGuests = madeBooking["People"] as! String
//                let bookingTime = madeBooking["Preferred Time"] as! String
                let date = NSDate(timeIntervalSince1970: TimeInterval((madeBooking["Preferred Time"] as! Timestamp).seconds))
                let formatter = DateFormatter()
                formatter.dateFormat = "d MMM y,HH:mm"
                var timeString = formatter.string(from: date as Date)
                cell.nameLabel?.text = bookingFullName
                cell.emailLabel?.text = bookingEmail
                cell.guestsLabel?.text = bookingGuests
                cell.timeLabel?.text = timeString
        }
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
