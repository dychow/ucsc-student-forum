//
//  AddressViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 2/19/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
        
        if  !addressTextField.text!.isEmpty {
        
            UserDefaults.standard.set(addressTextField.text, forKey:"itemAddress")

            navigationController?.popViewController(animated: true)
            
        } else {
            
            addressTextField.placeholder = "Please enter an address"
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if  !addressTextField.text!.isEmpty {
            
            UserDefaults.standard.set(addressTextField.text, forKey:"itemAddress")
            
            navigationController?.popViewController(animated: true)
            
        } else {
            
            addressTextField.placeholder = "Please enter an address"
            
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addressObject = UserDefaults.standard.object(forKey: "itemAddress")
        if let address = addressObject as? String {
            if address != "enter address" {
                addressTextField.text = address
            }
        }

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
