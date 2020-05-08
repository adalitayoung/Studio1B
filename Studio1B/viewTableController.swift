import UIKit
class viewTableController: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
    }


    //Give action to the button
    @IBAction func tableOneButton(_sender: Any){
        let alert = UIAlertController(title: " Table Number 1" , message: "This Table Holds 4 People." ,preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Reserve" , style: .default){(action) in print("THIS TABLE HAS NOW BEEN BOOKED")}
        let action2 = UIAlertAction(title: "Cancel" , style: .default){(action) in print("THIS TABLE BOOKING HAS NOW BEEN CANCELLED")}
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func tableTwoButton(_sender: Any){
       let alert = UIAlertController(title: " Table Number 2" , message: "This Table Holds 4 People." ,preferredStyle: .alert)
       let action1 = UIAlertAction(title: "Reserve" , style: .default){(action) in print("THIS TABLE HAS NOW BEEN BOOKED")}
       let action2 = UIAlertAction(title: "Cancel" , style: .default){(action) in print("THIS TABLE BOOKING HAS NOW BEEN CANCELLED")}
       alert.addAction(action1)
       alert.addAction(action2)
       present(alert, animated: true, completion: nil)
    }


}
