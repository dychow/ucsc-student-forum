//
//  FirstViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 1/20/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 216
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
       
       // var cellContenView = UIView(frame: CGRect(x: 10, y: 0, width: self.view.bounds.width-20, height: 236))
        
            //itemCell.backgroundColor = UIColor.clear
        
        //cellContenView.layer.m//asksToBounds=false
        
            //cellContenView.backgroundColor = UIColor.white
        //cellContenView.layer.cornerRadius = 5.0
        
        //itemCell.contentView.addSubview(cellContenView)
        itemCell.layer.borderWidth = 9
        itemCell.layer.borderColor = UIColor.clear.cgColor
        itemCell.layer.cornerRadius = 7

        return itemCell
    }
    
    @IBAction func sendToDatabase(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        //var intValue = ref.child("test/testvalue").observeSingleEvent
        ref.child("test").child("testvalue").observeSingleEvent(of: .value, with: {
            (snapshot) in
            
            if !snapshot.exists() {return}
            
            let value = snapshot.value as? NSNumber
            ref.child("test").child("testvalue").setValue((value?.intValue)!+1)

        })
        
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        ref.child("test").child("testvalue").setValue(value+1)

        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
    }

    @IBOutlet weak var tableView: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

