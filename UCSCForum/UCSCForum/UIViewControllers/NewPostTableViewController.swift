//
//  NewPostTableViewController.swift
//  
//
//  Created by Jason Di Chen on 2/19/18.
//

import UIKit
import Firebase

class NewPostTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var itemNameTextField: UITextField!

    @IBOutlet weak var itemDetailTextField: UITextView!
    
    @IBOutlet var newPostTable: UITableView!
    
    @IBOutlet weak var Category: UITableViewCell!
    
    @IBOutlet weak var Address: UITableViewCell!
    
    @IBOutlet weak var deliveryStatus: UISwitch!
    
    @IBAction func postButton(_ sender: Any) {

        var ref: DatabaseReference!
        
        ref = Database.database().reference().child("market")
        
        let addressObject = UserDefaults.standard.object(forKey: "itemAddress")
    
        if  itemNameTextField.text!.isEmpty {
            
            itemNameTextField.placeholder = "Please Enter the Name of the Item"
            
        } else {
        
            if  !(addressObject as! String == "" && !deliveryStatus.isOn) {
                
                let itemNameObject = UserDefaults.standard.object(forKey: "itemName")
                
                let itemDetailObject = UserDefaults.standard.object(forKey: "itemDetail")
                
                var itemName: [String]
                
                var itemDetail: [String]
                
                //Set itemName to FireBase
                if let tempItemName = itemNameObject as? [String] {
                    
                    itemName = tempItemName
                    
                    itemName.append(itemNameTextField.text!)
                    ref.child(itemNameTextField.text!).child("itemName").setValue(itemNameTextField.text!)
                    
                } else {
                    
                    itemName = [itemNameTextField.text!]
                    
                }
                
                //Set itemDetail to Firebase
                if let tempItemDetail = itemDetailObject as? [String] {
                    
                    itemDetail = tempItemDetail
                    
                    itemDetail.append(itemDetailTextField.text!)
                    ref.child(itemNameTextField.text!).child("itemDetail").setValue(itemDetailTextField.text!)
                    
                } else {
                    
                    itemDetail = [itemDetailTextField.text!]
                    
                }
                
                //Set Delivery to Firebase
                ref.child(itemNameTextField.text!).child("itemDelivery").setValue(false)
                
                
                //Set Address to Firebase
                let addressObject = UserDefaults.standard.object(forKey: "itemAddress")
                if let address = addressObject as? String {
                    ref.child(itemNameTextField.text!).child("itemAddress").setValue(address)
                }
                
                //Set Category to Firebase
                ref.child(itemNameTextField.text!).child("itemCategory").setValue("this is Category")
                let categoryObject = UserDefaults.standard.object(forKey: "categorySelected")
                if let category = categoryObject as? String {
                    ref.child(itemNameTextField.text!).child("itemCategory").setValue(category)
                }
                
                //Set Poster's Name to Firebase
                ref.child(itemNameTextField.text!).child("posterName").setValue("Roy Huang")
                
                //Create comments section in Firebase
                ref.child(itemNameTextField.text!).child("comments").child("0").child("comment").setValue("Example Comment")
                
                ref.child(itemNameTextField.text!).child("comments").child("0").child("name").setValue("Example Username")
                
                //Set Delivery to Firebase
                ref.child(itemNameTextField.text!).child("itemDelivery").setValue(deliveryStatus.isOn)
                
                //Update local value
                UserDefaults.standard.set(itemName, forKey:"itemName")
                UserDefaults.standard.set(itemDetail, forKey:"itemDetail")
                UserDefaults.standard.set("", forKey:"categorySelected")
                UserDefaults.standard.set("", forKey:"itemAddress")
                navigationController?.popToRootViewController(animated: true)
                
            } else {
               Address.detailTextLabel?.text = "please enter address or turn on delivery"
            }
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView)
    {
        print ("Began")
        if (itemDetailTextField.text == "Say something about the item...")
        {
            itemDetailTextField.text = ""
            itemDetailTextField.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        print ("Ended")
        if (itemDetailTextField.text.count == 0)
        {
            itemDetailTextField.text = "Say something about the item..."
            itemDetailTextField.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        newPostTable.reloadData()
        
        if (itemDetailTextField.text.count == 0)
        {
            itemDetailTextField.text = "Say something about the item..."
            itemDetailTextField.textColor = .lightGray
        }
        
        itemDetailTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        itemDetailTextField.layer.borderWidth = 1.0
        itemDetailTextField.layer.cornerRadius = 5
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let categoryObject = UserDefaults.standard.object(forKey: "categorySelected")
        if let category = categoryObject as? String {
            if category != "" {
                Category.detailTextLabel?.text = category
            }
        }
        
        let addressObject = UserDefaults.standard.object(forKey: "itemAddress")
        if let address = addressObject as? String {
            if address != "" {
                Address.detailTextLabel?.text = address
            }
        }
        
        
        
        newPostTable.reloadData()
    }

}
