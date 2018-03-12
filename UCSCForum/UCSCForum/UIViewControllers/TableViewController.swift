//
//  TableViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 1/23/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

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
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {self.performSegue(withIdentifier: "loginSegue", sender: self)}
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("before")
       // self.performSegue(withIdentifier: "loginSegue", sender: self)
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
            
            var ref = Database.database().reference().child("users").child(uid!)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                self.name = value!["name"] as! String
                self.bio = value!["about"] as! String
                self.profileImageUrl = value!["profileImageUrl"] as! String
                
                
                UserDefaults.standard.setValuesForKeys(["name": self.name])
                UserDefaults.standard.setValuesForKeys(["bio": self.bio])
                UserDefaults.standard.setValuesForKeys(["profileImageUrl": self.profileImageUrl])
                
            })
            
            
        }

        name = UserDefaults.standard.value(forKey: "name") as! String
        bio = UserDefaults.standard.value(forKey: "bio") as! String
        profileImageUrl = UserDefaults.standard.value(forKey: "profileImageUrl") as! String
        
        nameLabel.text = name
        bioLabel.text = bio
        
        if let url = NSURL(string: profileImageUrl!) {
            if let data = NSData(contentsOf: url as URL) {
                profileImage.image = UIImage(data: data as Data)
            }
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
    
    // override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    //return 0
    // }
    
    //  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //     return 1
    //  }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

