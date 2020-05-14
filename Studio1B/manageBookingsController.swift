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
    
    let bookingEmail = UserDefaults.standard.object(forKey: "Email") as! String
    
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueResuableCell(withIdentifier: "cell", for indexPath) as! bookingCell
//        return cell
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
