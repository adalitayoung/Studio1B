//
//  EditBooking.swift
//  Studio1B
//
//  Created by Adalita Young on 28/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit
import Firebase

class EditBooking: UIViewController {

    var booking = [String: Any]()
    let db = Firestore.firestore()
    @IBOutlet weak var FirstName_TF: UITextField!
    @IBOutlet weak var LastName_TF: UITextField!
    @IBOutlet weak var ContactNumber_TF: UITextField!
    @IBOutlet weak var Email_TF: UITextField!
    @IBOutlet weak var PreferredDate_TF: UITextField!
    @IBOutlet weak var PreferredTime_TF: UITextField!
    @IBOutlet weak var NumberOfGuests_TF: UITextField!
    @IBOutlet weak var AdditionalMessage_TF: UITextField!
    @IBOutlet weak var MissingDetailsMessage: UILabel!
    @IBOutlet weak var Update_BTN: UIButton!
    
    var userEmail = ""
    
    func updateBooking(SuitableTime: String, ContactNumber: String, SuitableDate: String, Email: String, FirstName: String, LastName: String, NumberOfGuests: String, specialConsideration: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        let preferredDatetime = dateFormatter.date(from: SuitableDate+" "+SuitableTime)!
        print(preferredDatetime)
        print(SuitableDate)
        print(SuitableTime)
        let timeStamp = Timestamp(date: preferredDatetime)
        var match = false

        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: timeStamp.dateValue() as Date)
        let todayComponents = calendar.dateComponents([.year, .month, .day, .hour], from: Date())
        print(todayComponents)
        db.collection("Booking").whereField("CustomerID", isEqualTo: userEmail).getDocuments() {(querySnapshot, error) in
            if let error = error {
                print(error)
            }
            else{
                for document in querySnapshot!.documents {
                    if(!match){
                        let time = (document.data()["Preferred Time"] as! Timestamp).dateValue()
                        if (self.booking["BookingID"] as! String != document.data()["BookingID"] as! String) {
                            let documentComponents = calendar.dateComponents([.year, .month, .day, .hour], from: time as Date)
                            if (documentComponents.year! == components.year!) && (documentComponents.month! == components.month!) && (documentComponents.day! == components.day!) && (((components.hour! >= 12 && components.hour! <= 16) && (documentComponents.hour! >= 12 && documentComponents.hour! <= 16)) || ((components.hour! >= 17 && components.hour! < 24) && (documentComponents.hour! >= 17 && documentComponents.hour! < 24))){
                                    print("Already made a booking for this time slot")
                                    self.MissingDetailsMessage?.text = "Booking already exists"
                                    self.MissingDetailsMessage.textColor = UIColor.red
                                    match = true
                            }
                            if (Date() > timeStamp.dateValue()){
                                print("Can't make a booking in the past")
                                self.MissingDetailsMessage?.text = "Cannot make a booking in the past"
                                self.MissingDetailsMessage.textColor = UIColor.red
                                match = true
                            }
                            print("line 72")
                        }
                    }

                    
                }
                print("Outside for loop")
                if (!match){
                    self.MissingDetailsMessage.textColor = UIColor.white
                    //self.Update_BTN.isEnabled = false
                    self.Update_BTN.backgroundColor = UIColor.gray
                    print(timeStamp)

                    self.db.collection("Booking").document(self.booking["BookingID"] as! String).updateData(["Preferred Time": timeStamp, "ContactNumber": ContactNumber, "CustomerID" : Email, "Email Address" : Email, "FirstName": FirstName, "LastName": LastName, "People" : NumberOfGuests, "Special Considerations" : specialConsideration])
                    { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added.")
                            
//                            Check Orders here and update time.
                            
                            let alert = UIAlertController(title: "Booking Record Updated",
                                                                message: "Booking has been Successfully Updated",
                                                                preferredStyle: .alert)

                            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
                                self.performSegue(withIdentifier: "bookingUpdated", sender: self)
                            }))

                            self.present(alert, animated: true)
                                
                        }
                    }
                            
                    
                    
                }
            }
        }
        
    }
    
    func errorChecking(SuitableTime: String, ContactNumber: String, SuitableDate: String, Email: String, FirstName: String, LastName: String, NumberOfGuests: String, specialConsideration: String) -> Bool {
        var result = true;
        let errorColour = UIColor.red

        // Resetting the borders
        FirstName_TF.layer.borderWidth = 0
        LastName_TF.layer.borderWidth = 0
        ContactNumber_TF.layer.borderWidth = 0
        Email_TF.layer.borderWidth = 0
        PreferredDate_TF.layer.borderWidth = 0
        PreferredTime_TF.layer.borderWidth = 0
        NumberOfGuests_TF.layer.borderWidth = 0
      
      //First Name
        if (FirstName.isEmpty){
            FirstName_TF.layer.borderWidth = 1.0
            FirstName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

      // Last name
        if (LastName.isEmpty){
            LastName_TF.layer.borderWidth = 1.0
            LastName_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
      // Contact Number
        // Limit to 10
        if (ContactNumber.isEmpty) || (ContactNumber.count != 10){
            ContactNumber_TF.layer.borderWidth = 1.0
            ContactNumber_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

      // Email Address
        let regexEmail = try! NSRegularExpression(pattern: #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#)
        let emailResults = regexEmail.matches(in:Email,range: NSRange(Email.startIndex..., in: Email))
        print(emailResults)

        // Has to have @ and .com
        if (Email.isEmpty) || (emailResults.count == 0){
            Email_TF.layer.borderWidth = 1.0
            Email_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
       
       //This DOB part can be changed to SuitableDate but dont know HOW??

        let regexDate = try! NSRegularExpression(pattern: #"^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"#)
        let results = regexDate.matches(in:SuitableDate,range: NSRange(SuitableDate.startIndex..., in: SuitableDate))
        print(results)

        if (SuitableDate.isEmpty) || (results.count == 0){
            PreferredDate_TF.layer.borderWidth = 1.0
            PreferredDate_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

       // This part is Suitable Time but have to set a limit of 24 hrs on it idk how to do it???
        if (SuitableTime.isEmpty){
            PreferredTime_TF.layer.borderWidth = 1.0
            PreferredTime_TF.layer.borderColor = errorColour.cgColor
            result = false
        }
        
        if (NumberOfGuests.isEmpty || NumberOfGuests == "0" ){
            NumberOfGuests_TF.layer.borderWidth = 1.0
            NumberOfGuests_TF.layer.borderColor = errorColour.cgColor
            result = false
        }

        return result
    }
    
    @IBAction func Update_BTN(_ sender: Any) {
        let errorsChecked = self.errorChecking(SuitableTime: self.PreferredTime_TF!.text!, ContactNumber: self.ContactNumber_TF.text!, SuitableDate: self.PreferredDate_TF.text!, Email: self.Email_TF.text!, FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, NumberOfGuests: self.NumberOfGuests_TF!.text!, specialConsideration: self.AdditionalMessage_TF!.text!)
        if (errorsChecked){
           // Update_BTN.isEnabled = false
            Update_BTN.backgroundColor = UIColor.gray
            updateBooking(SuitableTime: self.PreferredTime_TF!.text!, ContactNumber: self.ContactNumber_TF.text!, SuitableDate: self.PreferredDate_TF.text!, Email: self.Email_TF.text!, FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, NumberOfGuests: self.NumberOfGuests_TF!.text!, specialConsideration: self.AdditionalMessage_TF!.text!)
        }
        else {
            MissingDetailsMessage.textColor = UIColor.red
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        if let user = user {
            userEmail = user.email as! String
            self.Email_TF?.text = userEmail
        }
        
        FirstName_TF.text! = booking["FirstName"] as! String
        LastName_TF.text! = booking["LastName"] as! String
        ContactNumber_TF.text! = booking["ContactNumber"] as! String
        Email_TF.text! = booking["Email Address"] as! String
        NumberOfGuests_TF.text! = booking["People"] as! String
        AdditionalMessage_TF.text! = booking["Special Considerations"] as! String
        let date = NSDate(timeIntervalSince1970: TimeInterval((booking["Preferred Time"] as! Timestamp).seconds))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateArray = formatter.string(from: date as Date).components(separatedBy: " ")
        PreferredDate_TF.text! = dateArray[0]
        
//        formatter.timeStyle = .short
  //      formatter.dateStyle = .none
        PreferredTime_TF.text! = dateArray[1]
        
        MissingDetailsMessage.textColor = UIColor.white

        // Do any additional setup after loading the view.
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
