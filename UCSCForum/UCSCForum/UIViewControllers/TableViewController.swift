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
    var livingArea: String?
    var yearInfo: String?
    var email: String?
    var phone: String?
    
    var profileImageUrl: String?
    var flag = 0;
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var livingAreaLabel: UILabel!
    @IBOutlet weak var yearInfoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {self.performSegue(withIdentifier: "loginSegue", sender: self)}
        getUserData()
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        print("before")
        checkLogin()

        getUserData()

        //checkLogin()
        //self.performSegue(withIdentifier: "loginSegue", sender: self)
        print("afer")
        
        tableview.reloadData()
        
        
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
            let ref = Database.database().reference().child("users").child(uid!)
            
            //var ref = Database.database().reference().child("users").child(uid!)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                if value != nil{
                self.name = value!["name"] as? String
                self.bio = value!["about"] as? String
                self.profileImageUrl = value!["profileImageUrl"] as? String
                self.livingArea = value!["Street_Add"] as? String
                self.yearInfo = value!["year and major"] as? String
                self.email = value!["email"] as? String
                self.phone = value!["Phone_Num"] as? String
                
                
                print(self.name)
                print(self.bio)
                print(self.livingArea)
                print(self.yearInfo)
                print(self.email)
                print(self.phone)
                
                self.nameLabel.text = self.name
                self.bioLabel.text = self.bio
                self.livingAreaLabel.text = self.livingArea
                self.yearInfoLabel.text = self.yearInfo
                self.emailLabel.text = self.email
                self.phoneLabel.text = self.phone
                
                
                if let url = NSURL(string: self.profileImageUrl!) {
                    if let data = NSData(contentsOf: url as URL) {
                        self.profileImage.image = UIImage(data: data as Data)
                    }
                }
                }
                UserDefaults.standard.setValuesForKeys(["name": self.name])
                UserDefaults.standard.setValuesForKeys(["bio": self.bio])
                UserDefaults.standard.setValuesForKeys(["profileImageUrl": self.profileImageUrl])
                UserDefaults.standard.setValuesForKeys(["livingArea": self.livingArea])
                UserDefaults.standard.setValuesForKeys(["yearInfo": self.yearInfo])
                UserDefaults.standard.setValuesForKeys(["email": self.email])
                UserDefaults.standard.setValuesForKeys(["phone": self.phone])
                    
                
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

