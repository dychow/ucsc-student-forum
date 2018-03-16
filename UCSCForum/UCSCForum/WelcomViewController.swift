//
//  WelcomViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 3/15/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class WelcomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func go(){
        self.performSegue(withIdentifier: "startSegue", sender: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let label1 = UILabel()
        label1.text = "大学圈"
        label1.font = UIFont(name: "Arial", size: 30)
        label1.frame = CGRect(x: 300, y: 50, width: 300, height: 100)
        label1.textColor = UIColor.init(red: 255/255, green: 73/255, blue: 77/255, alpha: 0.8)
        let label2 = UILabel()
        label2.text = "κοινότητα"
        label2.font = UIFont(name: "Arial", size: 28)
        label2.frame = CGRect(x: 200, y: 550, width: 300, height: 100)
        label2.textColor = UIColor.init(red: 255/255, green: 73/255, blue: 77/255, alpha: 0.6)
        
        let label3 = UILabel()
        label3.text = "تواصل اجتماعي"
        label3.font = UIFont(name: "Arial", size: 35)
        label3.frame = CGRect(x: 400, y: 260, width: 300, height: 100)
        label3.textColor = UIColor.init(red: 255/255, green: 73/255, blue: 77/255, alpha: 0.7)
        
        let label4 = UILabel()
        label4.text = "Comunità"
        label4.font = UIFont(name: "Arial", size: 32)
        label4.frame = CGRect(x: 270, y: 490, width: 100, height: 100)
        label4.textColor = UIColor.init(red: 255/255, green: 73/255, blue: 77/255, alpha: 0.7)
        

        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(label4)

        var timer = Timer.scheduledTimer(timeInterval:2, target: self, selector: #selector(go), userInfo: nil, repeats: false)
        
        UIView.animate(withDuration: 2.5, animations: {
            label1.frame = CGRect(x: 100, y: 50, width: 300, height: 100)
            label2.frame = CGRect(x: 50, y: 550,    width: 300, height: 100)
            label3.frame = CGRect(x: 200, y: 260, width: 300, height: 100)
            label4.frame = CGRect(x: 70, y: 490, width: 300, height: 100)

        })
        

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
