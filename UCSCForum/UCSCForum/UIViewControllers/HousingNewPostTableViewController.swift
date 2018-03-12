//
//  HousingNewPostTableViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class HousingNewPostTableViewController: UITableViewController {

    var finalAddress :String = ""
    
    @IBOutlet weak var HousingInfo: UITextField!
    
    @IBOutlet weak var HousingDetail: UITextView!
    
    @IBOutlet weak var Address: UITableViewCell!
    
    @IBOutlet weak var City: UITableViewCell!
    
    @IBOutlet weak var State: UITableViewCell!
    
    @IBOutlet weak var ZipCode: UITableViewCell!
    
    @IBAction func postPushed(_ sender: Any) {
        var ref: DatabaseReference!
        if Address.detailTextLabel?.text != "Enter Address" {
            finalAddress = "\(Address.detailTextLabel!.text!.description), \( City.detailTextLabel!.text!.description), \(State.detailTextLabel!.text!.description) \(ZipCode.detailTextLabel!.text!.description)"
            let houseID = randomString(length: 8)
            ref = Database.database().reference().child("housing").child(houseID.description)
            ref.child("address").setValue(finalAddress)
            ref.child("posterName").setValue(Auth.auth().currentUser?.uid)
            ref.child("description").setValue(HousingDetail.text!.description)
            ref.child("houseName").setValue(HousingInfo.text!.description)
            
            //Create comments section in Firebase
            ref.child("comments").child("0").child("comment").setValue("Example Comment")
            ref.child("comments").child("0").child("name").setValue("Example Username")
            print ("the address is \(finalAddress)")
        }
        UserDefaults.standard.set("Enter Address", forKey: "HousingAddress")
        UserDefaults.standard.set("Santa Cruz", forKey: "HousingCity")
        UserDefaults.standard.set("CA", forKey: "HousingState")
        UserDefaults.standard.set("95060", forKey: "HousingZipCode")
        
        navigationController?.popViewController(animated: true)
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let addressObject = UserDefaults.standard.object(forKey: "HousingAddress")
        let cityObject = UserDefaults.standard.object(forKey: "HousingCity")
        let stateObject = UserDefaults.standard.object(forKey: "HousingState")
        let zipCodeObject = UserDefaults.standard.object(forKey: "HousingZipCode")
    
        if let tempAddress = addressObject as? String {
            if tempAddress != "" {
                Address.detailTextLabel?.text = tempAddress
            } else {
                Address.detailTextLabel?.text = "Enter Address"
            }
        }
        
        if let tempCity = cityObject as? String {
            if tempCity != "" {
                City.detailTextLabel?.text = tempCity
            } else {
                City.detailTextLabel?.text = "Santa Cruz"
            }
        }
        
        if let tempState = stateObject as? String {
            if tempState != "" {
                State.detailTextLabel?.text = tempState
            } else {
                State.detailTextLabel?.text = "CA"
            }
        }
        
        if let tempZipCode = zipCodeObject as? String {
            if tempZipCode != "" {
                ZipCode.detailTextLabel?.text = tempZipCode
            } else {
                ZipCode.detailTextLabel?.text = "Enter Zip Code"
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
