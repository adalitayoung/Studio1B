//Create New Booking
import UIKit
import Firebase

class CreateNewBooking: BookingController {
    
    @IBOutlet weak var FirstName_TF: UITextField!
    @IBOutlet weak var LastName_TF: UITextField!
    @IBOutlet weak var Email_TF: UITextField!
    @IBOutlet weak var ContactNumber_TF: UITextField!
    @IBOutlet weak var SuitableDate_TF: UITextField!
    @IBOutlet weak var SuitableTime_TF: UITextField!
    @IBOutlet weak var NumberOfGuests_TF: UITextField!
    @IBOutlet weak var SpecialConsideration_TF: UITextField!
    @IBOutlet weak var MissingDetailsMessage: UILabel!
    @IBOutlet weak var create_BTN: UIButton!
    
    //@IBOutlet var datePicker: [UIDatePicker]!
    
    
    func createRecord(SuitableTime: String, ContactNumber: String, SuitableDate: String, Email: String,

                      FirstName: String, LastName: String, NumberOfGuests: String, specialConsideration: String) {
        
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        let minute = calender.component(.minute, from: date)
        let second = calender.component(.second, from: date)
        let Day = calender.component(.day, from: date)
        let month = calender.component(.month, from: date)
        let year = calender.component(.year, from: date)
        
        
        let documentID = Email_TF.text!
        //##:## dd - MM - yyyy
        // new collection config, document in there that is a count document, an int field that is a count of the bookings, each time you want to createa  new boking, fetch count, increment, convert back to string with B infront
        let timeStamp = Timestamp(date: date)
        db.collection("Booking").document("\(hour)\(minute)\(second)\(Day)\(month)").setData(["Preferred Time": timeStamp, "ContactNumber": ContactNumber, "CustomerID" : Email, "Email Address" : Email, "FirstName": FirstName, "LastName": LastName, "People" : NumberOfGuests, "BookingID" : "\(hour)\(minute)\(second)\(Day)\(month)", "Special Considerations" : specialConsideration])

        // Convert DOB to date
        


        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added.")
                
//                let alert = UIAlertController(title: "Booking Record Created",
//                                                    message: "Booking has been Successfully Created",
//                                                    preferredStyle: .alert)

//                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
//                    self.performSegue(withIdentifier: "newBookingCreated", sender: self)
//                }))
                
                //self.present(alert, animated: true)
                
            }
        }


    }
    
    func errorChecking(SuitableTime: Int, ContactNumber: String, SuitableDate: String, Email: String,
                          FirstName: String, LastName: String, NumberOfGuests: Int) -> Bool {
        var result = true;
        let errorColour = UIColor.red

        // Resetting the borders
        FirstName_TF.layer.borderWidth = 0
        LastName_TF.layer.borderWidth = 0
        ContactNumber_TF.layer.borderWidth = 0
        Email_TF.layer.borderWidth = 0
        SuitableDate_TF.layer.borderWidth = 0
        SuitableTime_TF.layer.borderWidth = 0
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

//        let regexDOB = try! NSRegularExpression(pattern: #"^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$"#)
//        let results = regexDOB.matches(in:DateOfBirth,range: NSRange(DateOfBirth.startIndex..., in: DateOfBirth))
//        print(results)
//
//        if (SuitableDate.isEmpty) || (results.count == 0){
//            DateOfBirth_TF.layer.borderWidth = 1.0
//            DateOfBirth_TF.layer.borderColor = errorColour.cgColor
//            result = false
//        }
//
//       // This part is Suitable Time but have to set a limit of 24 hrs on it idk how to do it???
//        if (SuitableTime.isEmpty){
//            AccountNumber_TF.layer.borderWidth = 1.0
//            AccountNumber_TF.layer.borderColor = errorColour.cgColor
//            result = false
//        }
        
        
        
        if (NumberOfGuests == 0){
            //Role_TF.layer.borderWidth = 1.0
            //Role_TF.layer.borderColor = errorColour.cgColor
            //result = false
        }

        return result
    }
    

    @IBAction func submitNewBooking_BTN(_ sender: Any) {
        createRecord(SuitableTime: self.SuitableTime_TF!.text!, ContactNumber: self.ContactNumber_TF.text!, SuitableDate: self.SuitableDate_TF.text!, Email: self.Email_TF.text!, FirstName: self.FirstName_TF.text!, LastName: self.LastName_TF.text!, NumberOfGuests: self.NumberOfGuests_TF!.text!, specialConsideration: self.SpecialConsideration_TF!.text!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        MissingDetailsMessage.textColor = UIColor.white
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

