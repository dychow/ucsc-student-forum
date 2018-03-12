//
//  HousingStateViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class HousingStateViewController: UIViewController {

    @IBOutlet weak var HousingState: UITextField!
    
    @IBAction func donePushed(_ sender: Any) {
        
        UserDefaults.standard.set(HousingState.text, forKey: "HousingState")
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let stateObject = UserDefaults.standard.object(forKey: "HousingState")
        if let tempState = stateObject as? String {
            if tempState != "CA" {
                HousingState.text = tempState
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
