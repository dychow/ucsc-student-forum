//
//  WelcomeVC.swift
//  UCSCForum
//
//  Created by MacDouble on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(viewTransfer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @objc func viewTransfer(){
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "startSegue", sender: self)
        }else{
            self.performSegue(withIdentifier: "signSegue",sender: self)
        
        }
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
