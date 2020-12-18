//
//  DashboardViewController.swift
//  LoginApp
//
//  Created by Ashisish on 11/6/20.
//

import UIKit
import Firebase

struct Studyset {
    let word : String
    let definition : String
    let uid : String
    let key : String
}

class DashboardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studySetArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studySetCell") as! StudySetUITableViewCelll
        cell.lbl.text = studySetArray[indexPath.row].word
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let StudySetvc = storyboard?.instantiateViewController(identifier: "SutdySetViewController") as? SutdySetViewController
        StudySetvc?.studySet = studySetArray[indexPath.row]
        self.navigationController?.pushViewController(StudySetvc!, animated: true)
    }
    
    var studySetArray = [Studyset]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        super.viewDidLoad()
        registerTableViewCells()
        getData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popViewController(animated: true)
        }
        catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func addSet_Action(_ sender: Any) {
    }
    
    func getData() {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
//        ref.child("StudyList").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            let values = snapshot.value as? [String : AnyObject]
//                for child in snapshot.children {
//                    let c = child as! DataSnapshot
//                    let dict = c.value as? [String : AnyObject]
//
//                    let uid = dict!["uid"] as! String
//                    let key = dict!["key"] as! String
//                    let word = dict!["word"] as! String
//                    let definition = dict!["definition"] as! String
//
//                    let studyset = Studyset(word: word, definition: definition, uid: uid, key: key)
//
//                    print(studyset)
//                    self.studySetArray.append(studyset)
//                    print(self.studySetArray)
//                    self.tableView.reloadData()
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//          }) { (error) in
//            print(error.localizedDescription)
//        }
        
        ref.child("StudyList").child(userID!).observe(.value) { (snapshot) in
            self.studySetArray = [Studyset]()

            let values = snapshot.value as? [String : AnyObject]
            for child in snapshot.children {
                let c = child as! DataSnapshot
                let dict = c.value as? [String : AnyObject]

                let uid = dict!["uid"] as! String
                let key = dict!["key"] as! String
                let word = dict!["word"] as! String
                let definition = dict!["definition"] as! String



                let studyset = Studyset(word: word, definition: definition, uid: uid, key: key)

                print(studyset)
                self.studySetArray.append(studyset)
                print(self.studySetArray)
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
                        
        
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "StudySetUITableViewCelll",
                                  bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: "studySetCell")
    }
    
}


