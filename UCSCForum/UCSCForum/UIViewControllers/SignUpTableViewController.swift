//
//  SignUpTableViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 2/1/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var confirmTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var usernameTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        setupBorder(view: usernameTf)
        setupBorder(view: passwordTf)
        setupBorder(view: confirmTf)
        proceedButton.layer.cornerRadius = 9
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        view.addGestureRecognizer(tap)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
<<<<<<< HEAD
    
    @IBAction func proceedButton(_ sender: Any) {
        if let username = usernameTf.text{
            let index = username.index(username.endIndex, offsetBy: -3)
            
            let range = index...
            
            if username[range] == "edu"{
                warningLabel.text = "Please enter your student email"
                return
            }
        }else{
            warningLabel.text = "Please enter your student email"
            return
        }
        
        if let password = passwordTf.text{
            if password.count <= 8{
                "Password requires a minimum of 8 characters' length"
=======
    @IBAction func doneButton(_ sender: Any) {
        if let validEmail = usernameTf.text{
            if !validEmail.hasSuffix("@ucsc.edu") {
                errorLabel.text = "Not a valid ucsc.edu email"
                return
            }
        }

        if let confirm = confirmTf.text{
            if confirm != passwordTf.text{
                errorLabel.text = "Confirm password doesn't match"
>>>>>>> 86e8e1ed30ed7c81b636a529fe955280f13dca8f
                return
            }
        }else{
            warningLabel.text = "Please enter your password"
            return
        }
        
        if let confirm = confirmTf.text{
            if passwordTf.text != confirm{
                "Please re-confirm your password"
                return
            }
            
        }else{
            warningLabel.text = "Please confirm your password"
            return
        }
        //verification email should be sent here
        
        self.performSegue(withIdentifier: "verifySegue", sender: self)
        
        /*
        if let username = usernameTf.text, let password = passwordTf.text{
            Auth.auth().createUser(withEmail: username, password: password, completion: {(user, error) in
                if let firebaseError = error{
                    self.warningLabel.text = (firebaseError.localizedDescription)
                    return
                }
                
            })
        }*/
    }
    @objc func dissmissKeyboard(){
        
        view.endEditing(true)
        UIView.animate(withDuration: 0.25, animations: {
        self.setupBorder(view: self.passwordTf)
        self.setupBorder(view: self.confirmTf)
        self.setupBorder(view: self.usernameTf)
            })
    }
    func setupBorder(view: UIView){
        view.layer.cornerRadius = 9
        view.layer.borderColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.4).cgColor
        view.layer.borderWidth = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    @IBAction func usernameTfAction(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.setupBorder(view: self.passwordTf)
            self.setupBorder(view: self.confirmTf)
        })
    
        UIView.animate(withDuration: 0.25, animations: {
            self.usernameTf.layer.borderColor = UIColor.init(red: 1, green: 98/255, blue: 101/255, alpha: 0.8).cgColor
        })
    }
    @IBAction func passwordTfAction(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.setupBorder(view: self.usernameTf)
            self.setupBorder(view: self.confirmTf)
        })
        UIView.animate(withDuration: 0.25, animations: {
            self.passwordTf.layer.borderColor = UIColor.init(red: 1, green: 98/255, blue: 101/255, alpha: 0.8).cgColor
        })
    }
    @IBAction func confirmTfAction(_ sender: Any) {
        UIView.animate(withDuration: 0.25, animations: {
            self.setupBorder(view: self.passwordTf)
            self.setupBorder(view: self.usernameTf)
        })
        UIView.animate(withDuration: 0.25, animations: {
            self.confirmTf.layer.borderColor = UIColor.init(red: 1, green: 98/255, blue: 101/255, alpha: 0.8).cgColor
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
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
