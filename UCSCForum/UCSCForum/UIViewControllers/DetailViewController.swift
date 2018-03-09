//
//  DetailViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/3/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var dataNode: FirstViewController.Node?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Name is \(String(describing: dataNode?.getName))")
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
