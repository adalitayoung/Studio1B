//
//  ViewOrder.swift
//  Studio1B
//
//  Created by Adalita Young on 18/5/20.
//  Copyright © 2020 davidBolis. All rights reserved.
//

import UIKit

class ViewOrder: UIViewController {

    var order = [String:Any]()
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var tableNumber: UILabel!
    
    @IBOutlet weak var orderStatus: UISwitch!
    
    @IBAction func completeOrder(_ sender: Any) {
        if orderStatus.isOn {
            orderNumber.textColor = UIColor.red
            orderStatus.setOn(false, animated: true)
        }
        else{
           // tableNumber.text = "blah"
            orderStatus.setOn(true, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
