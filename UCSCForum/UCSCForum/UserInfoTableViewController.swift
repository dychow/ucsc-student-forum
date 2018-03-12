//
//  UserInfoTableViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 3/4/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class UserInfoTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameTf: styleTextFied!
    @IBOutlet var bioTf: styleTextFied!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func uploadImageButton(_ sender: Any) {
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
            profileImage.image = tempImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func completeButton(_ sender: Any) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageName).png")
            
        if let uploadData = UIImagePNGRepresentation(self.profileImage.image!){
            storageRef.putData(uploadData, metadata: nil, completion:
            {(metadata, error) in
                
                if error != nil{
                    print(error!)
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        let newUser = user(email:(Auth.auth().currentUser?.email)!, name: self.nameTf.text!, about: self.bioTf.text!, profileImageUrl: profileImageUrl)
                    self.registerUser(newUser: newUser)
                }
                
            })
            
        }
        
        
    }
    
    private func registerUser(newUser:user){
        var ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
    
        ref.setValue(newUser.toAnyObject())
        self.performSegue(withIdentifier: "gohomeSegue", sender: self)
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
