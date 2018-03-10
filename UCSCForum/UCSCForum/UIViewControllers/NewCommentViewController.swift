//
//  NewCommentViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/9/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class NewCommentViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var dataNode: FirstViewController.Node?
    
    var commentNumber = 0
    
    @IBOutlet weak var commentTextField: UITextView!
    
    @IBAction func postPushed(_ sender: Any) {
        
        postComment()
        
    }
    
    func postComment(){
        var ref: DatabaseReference!
        var userEmail = "Anonymous"
        
        if Auth.auth().currentUser != nil {
            userEmail = (Auth.auth().currentUser?.email)!
        }
        ref = Database.database().reference().child("market").child((dataNode?.getKey)!).child("comments")
        ref.observeSingleEvent(of: .value, with: {
            (snapshot) in
            for child in snapshot.children {
                self.commentNumber = self.commentNumber + 1  //for making sure comments are in order
                print("comment number incremented")
            }
            print("comment number is \(self.commentNumber)")
            ref.child("\(self.commentNumber)").child("comment").setValue(self.commentTextField.text)
            
            
            ref.child("\(self.commentNumber)").child("name").setValue(userEmail)
        })

        navigationController?.popViewController(animated: true)
        
    }
    
    //----------------------------------Placeholder for UITextView----------------------------------
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        print ("Began")
        if (commentTextField.text == "Write a comment...")
        {
            commentTextField.text = ""
            commentTextField.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        print ("Ended")
        if (commentTextField.text.count == 0)
        {
            commentTextField.text = "Write a comment..."
            commentTextField.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    
    //----------------------------------Keyboard Setting----------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Placeholder for UITextView
        if (commentTextField.text.count == 0)
        {
            commentTextField.text = "Write a comment..."
            commentTextField.textColor = .lightGray
        }
        
        //Set the style of UITextView
        commentTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        commentTextField.layer.borderWidth = 1.0
        commentTextField.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
