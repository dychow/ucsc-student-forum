//
//  HousingCityViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class HousingCityViewController: UIViewController {

    @IBOutlet weak var HousingCity: UITextField!
    
    @IBAction func donePushed(_ sender: Any) {
        
        UserDefaults.standard.set(HousingCity.text, forKey: "HousingCity")
        
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let cityObject = UserDefaults.standard.object(forKey: "HousingCity")
        if let tempCity = cityObject as? String {
            if tempCity != "Santa Cruz" {
                HousingCity.text = tempCity
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
