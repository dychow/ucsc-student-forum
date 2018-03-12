//
//  TableViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 1/23/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class TableViewController: UITableViewController {
    
    var name : String?
    var bio : String?
    var profileImageUrl: String?
    var flag = 0;
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {self.performSegue(withIdentifier: "loginSegue", sender: self)}
        getUserData()
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        print("before")
<<<<<<< HEAD
        getUserData()
=======

        checkLogin()
>>>>>>> 2dd23805260f4149ce61cfba072cffd832434406
        //self.performSegue(withIdentifier: "loginSegue", sender: self)
        print("afer")
        
        tableview.reloadData()
<<<<<<< HEAD
        
        
=======
>>>>>>> 2dd23805260f4149ce61cfba072cffd832434406
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.borderColor = UIColor.white.cgColor
        
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        
        
        self.view.addSubview(profileImage)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    func setupDefault(){
        nameLabel.isHidden = true;
        loginButton.isHidden = false;
        // logoutButton.titleLabel?.text = ""
        
    }
    
    func setupLogin(){
        nameLabel.isHidden = false;
        loginButton.isHidden = true;
        //logoutButton.titleLabel?.text = "log out"
    }
    @IBAction func logoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        viewWillAppear(false)
        tableview.reloadData()
    }
    
    func getUserData(){
        
        if Auth.auth().currentUser != nil{
            let uid = Auth.auth().currentUser?.uid
<<<<<<< HEAD
            let ref = Database.database().reference().child("users").child(uid!)
=======
            
            var ref = Database.database().reference().child("users").child(uid!)
>>>>>>> 2dd23805260f4149ce61cfba072cffd832434406
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.name = value!["name"] as? String
                self.bio = value!["about"] as? String
                self.profileImageUrl = value!["profileImageUrl"] as? String
                
                print(self.name)
                print(self.bio)
                self.nameLabel.text = self.name
                self.bioLabel.text = self.bio
                
                if let url = NSURL(string: self.profileImageUrl!) {
                    if let data = NSData(contentsOf: url as URL) {
                        self.profileImage.image = UIImage(data: data as Data)
                    }
                }
                UserDefaults.standard.setValuesForKeys(["name": self.name])
                UserDefaults.standard.setValuesForKeys(["bio": self.bio])
                UserDefaults.standard.setValuesForKeys(["profileImageUrl": self.profileImageUrl])
                
            })
            
        }

    }

    func checkLogin(){
        if Auth.auth().currentUser == nil{
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    
}

