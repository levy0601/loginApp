//
//  ForgetpasswordViewController.swift
//  LoginApp
//
//  Created by Hao Liu on 11/15/20.
//

import UIKit
import Firebase
import SwiftSpinner

class ForgetpasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resetEmail(_ sender: Any) {
        let email = txtEmail.text
        if email == "" {
            lblStatus.text = "Please enter email and correct password"
            return
        }
        if email?.isEmail == false {
            lblStatus.text = "Please enter valid e mail"
            return
        }
        SwiftSpinner.show("Sending reset Email")
        Auth.auth().sendPasswordReset(withEmail: email!) { error in
            SwiftSpinner.hide()
            
            if error != nil {
                self.lblStatus.text = error?.localizedDescription
                return
            }
            
            self.lblStatus.text = "Reset Email has sent to your email"
        }
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
