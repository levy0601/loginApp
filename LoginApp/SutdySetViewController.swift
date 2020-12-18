//
//  SutdySetViewController.swift
//  LoginApp
//
//  Created by Hao Liu on 12/17/20.
//

import UIKit
import Firebase

class SutdySetViewController: UIViewController {
    
    var studySet : Studyset!

    @IBOutlet weak var btnText: UIButton!
    
    var isWord = true
    override func viewDidLoad() {
        super.viewDidLoad()
        btnText.setTitle(studySet.word, for: .normal)
        btnText.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        btnText.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        btnText.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        // Do any additional setup after loading the view.
    }
    

    @IBAction func flip_action(_ sender: Any) {
        if isWord {
            isWord = false
            btnText.setTitle(studySet.definition, for: .normal)
            UIView.transition(with: btnText, duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
        }else{
            isWord = true
            btnText.setTitle(studySet.word, for: .normal)
            UIView.transition(with: btnText, duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromRight, animations: nil, completion: nil)
            
        }
    }
    
     @IBAction func delete_Action(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid

        
        ref.child("StudyList").child(userID!).child(studySet.key).removeValue()
        self.navigationController?.popViewController(animated: true)
     }
   

}
