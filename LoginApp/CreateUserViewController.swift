//
//  createUserViewController.swift
//  LoginApp
//
//  Created by Hao Liu on 11/15/20.
//

import UIKit
import Firebase
import SwiftSpinner

class createUserViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createUser(_ sender: Any) {
        
        let email = txtUsername.text
        let password = txtPassword.text

        if email == "" || password!.count < 6 {
            lblStatus.text = "Please enter email and correct password"
            return
        }
        if email?.isEmail == false {
            lblStatus.text = "Please enter valid e mail"
            return
        }

        SwiftSpinner.show("Creating user")
        Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
            SwiftSpinner.hide()
            if error != nil {
                self.lblStatus.text = error?.localizedDescription
                return
            }

            self.lblStatus.text = "User create Succeessfully!"
        }
    }
    
    

}
