//
//  AddSetViewController.swift
//  LoginApp
//
//  Created by Hao Liu on 12/16/20.
//
import UIKit
import Firebase


class AddSetViewController: UIViewController {

    @IBOutlet weak var txtWord: UITextField!
    @IBOutlet weak var txtDefinition: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSet_Action(_ sender: Any) {
        let word = txtWord.text
        let definition = txtDefinition.text
        
        let uid = Auth.auth().currentUser?.uid
        let userId = uid!
        
        let dbref = Database.database().reference()
        
        guard let key = dbref.child("StudyList").child(userId).childByAutoId().key else {return}
        
        let post = [
            "uid" : uid!,
            "word": word!,
            "definition" : definition!,
            "key" : key
        ] as [String : Any]
        
        let childUpdate = ["/StudyList/\(userId)/\(key)": post]
        dbref.updateChildValues(childUpdate)
        self.navigationController?.popViewController(animated: true)

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
