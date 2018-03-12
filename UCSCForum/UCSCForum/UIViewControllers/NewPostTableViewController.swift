//
//  NewPostTableViewController.swift
//  
//
//  Created by Jason Di Chen on 2/19/18.
//

import UIKit
import Firebase

class NewPostTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var imageViewOl: UIButton!
    var url: String = ""
    var postID: String = ""
    
    @IBOutlet weak var itemNameTextField: UITextField!

    @IBOutlet weak var itemDetailTextField: UITextView!
    
    @IBOutlet var newPostTable: UITableView!
    
    @IBOutlet weak var Category: UITableViewCell!
    
    @IBOutlet weak var Address: UITableViewCell!
    
    @IBOutlet weak var deliveryStatus: UISwitch!

    @IBAction func postButton(_ sender: Any) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageName).jpeg")
        
        if let uploadData = UIImageJPEGRepresentation((imageViewOl.imageView?.image)!, 0.6){
            storageRef.putData(uploadData, metadata: nil, completion:
                {(metadata, error) in
                    
                    if error != nil{
                        print(error)
                        return
                    }
                   
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        self.url = profileImageUrl
                        
                        
                    }
                    print(self.url)
                    var ref: DatabaseReference!
                    
                    ref = Database.database().reference().child("market")
                    ref.child(self.postID).child("imageUrl").setValue(self.url)
                    
            })
            
        }
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference().child("market")
        
        let addressObject = UserDefaults.standard.object(forKey: "itemAddress")
    
        if  itemNameTextField.text!.isEmpty {
            
            itemNameTextField.placeholder = "Please Enter the Name of the Item"
            
        } else {
        
            if  !(addressObject as! String == "" && !deliveryStatus.isOn) {
                
                var userEmail = "Anonymous"
                var userUID = ""
                if Auth.auth().currentUser != nil {
                    userEmail = (Auth.auth().currentUser?.email)!
                    userUID = (Auth.auth().currentUser?.uid)!
                }
                
                postID = randomString(length: 8)
                
                //Set item name to Firebase
                ref.child(postID).child("itemName").setValue(itemNameTextField.text!)
                
                //Set item detail to Firebase
                if itemDetailTextField.text != "Say something about the item..." {
                    ref.child(postID).child("itemDetail").setValue(itemDetailTextField.text!)
                } else {
                    ref.child(postID).child("itemDetail").setValue("")
                }

                //Set category to Firebase
                if Category.detailTextLabel?.text != "select category" {
                    ref.child(postID).child("itemCategory").setValue(Category.detailTextLabel?.text)
                } else {
                    ref.child(postID).child("itemCategory").setValue("")
                }
                
                if Category.detailTextLabel?.text != "select category" {
                    ref.child(postID).child("itemCategory").setValue(Category.detailTextLabel?.text)
                } else {
                    ref.child(postID).child("itemCategory").setValue("")
                }

                //Set address to Firebase
                if Address.detailTextLabel?.text != "required for undeliverable item" {
                    ref.child(postID).child("itemAddress").setValue(Address.detailTextLabel?.text)
                } else {
                    ref.child(postID).child("itemAddress").setValue("")
                }
                
                //Set Poster's Name to Firebase
                ref.child(postID).child("posterName").setValue(userUID)
                
                //Create comments section in Firebase
                ref.child(postID).child("comments").child("0").child("comment").setValue("Example Comment")
                
                ref.child(postID).child("comments").child("0").child("name").setValue("Example Username")
                
                //Set Delivery to Firebase
                ref.child(postID).child("itemDelivery").setValue(deliveryStatus.isOn)
                
                //Sets image url to Firebase
                if url != "" {
                    ref.child(postID).child("imageUrl").setValue(url)
                }
                
                //Update local value
                UserDefaults.standard.set("", forKey:"categorySelected")
                UserDefaults.standard.set("", forKey:"itemAddress")
                
                //Go back to root view controller
                navigationController?.popToRootViewController(animated: true)
                
            } else {
               Address.detailTextLabel?.text = "required for undeliverable item"
            }
        }
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

    
    //----------------------------------Placeholder for UITextView----------------------------------
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
    //----------------------------------End of Placeholder for UITextView----------------------------------
    
    override func viewDidLoad() {

        super.viewDidLoad()
        newPostTable.reloadData()
        
        //Placeholder for UITextView
        if (itemDetailTextField.text.count == 0)
        {
            itemDetailTextField.text = "Say something about the item..."
            itemDetailTextField.textColor = .lightGray
        }
        
        //Set the style of UITextView
        itemDetailTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        itemDetailTextField.layer.borderWidth = 1.0
        itemDetailTextField.layer.cornerRadius = 5
        
    }
    
    @IBAction func imageView(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImage : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"]{
            
            selectedImage = editedImage as! UIImage
            
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"]{
            selectedImage = originalImage as! UIImage
        }
        
        if let tempImage = selectedImage{
            imageViewOl.setImage(tempImage, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //----------------------------------Keyboard Setting----------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        itemDetailTextField.endEditing(true)
        itemNameTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //----------------------------------Load Category and Address----------------------------------
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
