//
//  HousingAddressViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class HousingAddressViewController: UIViewController {

    @IBOutlet weak var HousingAddress: UITextField!
    

    @IBAction func donePushed(_ sender: Any) {
        
        UserDefaults.standard.set(HousingAddress.text, forKey: "HousingAddress")
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let addressObject = UserDefaults.standard.object(forKey: "HousingAddress")
        if let tempAddress = addressObject as? String {
            if tempAddress != "Enter Address" {
                HousingAddress.text = tempAddress
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
