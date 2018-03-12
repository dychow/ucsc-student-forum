//
//  HousingZipCodeViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class HousingZipCodeViewController: UIViewController {

    @IBOutlet weak var HousingZipCode: UITextField!
    
    @IBAction func donePressed(_ sender: Any) {
        
        UserDefaults.standard.set(HousingZipCode.text, forKey: "HousingZipCode")
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let zipCodeObject = UserDefaults.standard.object(forKey: "HousingZipCode")
        if let tempZipCode = zipCodeObject as? String {
            if tempZipCode != "Enter Zip Code" {
                HousingZipCode.text = tempZipCode
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
