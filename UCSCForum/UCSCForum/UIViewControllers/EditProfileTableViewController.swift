//
//  EditProfileTableViewController.swift
//  UCSCForum
//
//  Created by Bond on 2018/3/8.
//  Copyright © 2018年 MacDouble. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class EditProfileTableViewController: UITableViewController {

    var ref:DatabaseReference?
    
    @IBOutlet weak var name_Tf: UITextField!
    
    @IBOutlet weak var email_Tf: UITextField!
    
    @IBOutlet weak var about_Tf: UITextField!
    
    @IBOutlet weak var yearAndMajor_Tf: UITextField!
    
    @IBOutlet weak var street_Tf: UITextField!
    
    @IBOutlet weak var city_Tf: UITextField!
    
    @IBOutlet weak var zip_Tf: UITextField!
    
    @IBOutlet weak var state_Tf: UITextField!
    
    @IBOutlet weak var country_Tf: UITextField!
    
    @IBOutlet weak var phone_Tf: UITextField!
    
    @IBAction func saveChanges_Button(_ sender: Any) {
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("name").setValue(name_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("email").setValue(email_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("about").setValue(about_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("year and major").setValue(yearAndMajor_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("Street_Add").setValue(street_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("City").setValue(city_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("ZipCode").setValue(zip_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("State").setValue(state_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("Country").setValue(country_Tf.text)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!).child("Phone_Num").setValue(phone_Tf.text)
        
            // Dimiss the popover
            //presentingViewController?.dismiss(animated: true, completion: nil)
        
            performSegue(withIdentifier: "doneSegue", sender: EditProfileTableViewController())
        
    }
    /*
    func getUserData(){
        
        if Auth.auth().currentUser != nil{
            let uid = Auth.auth().currentUser?.uid
            let ref = Database.database().reference().child("users").child(uid!)
            
            //var ref = Database.database().reference().child("users").child(uid!)
            
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
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the firebase reference
        ref = Database.database().reference()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

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
