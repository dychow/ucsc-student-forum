//
//  ThirdViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 1/20/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class ThirdViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selected: Int = 0
    var selectedItem: HousingDataStructures.Node?
    var itemCount: Int = 0
    var houseList = HousingDataStructures.LinkedList()
    

    @IBAction func houseRefresh(_ sender: Any) {
        table.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the houselist.getcount is \(houseList.getCount()!)")
        return houseList.getCount()!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        var currentItem = houseList.first
        
        var i = 0
        
        while i < indexPath.row {
            currentItem = currentItem?.next
            i += 1
        }
        
        itemCell.personName.text = currentItem?.getPoster
        
        itemCell.itemNameTextField.text = currentItem?.getName
        
        itemCell.itemDetailTextField.text = currentItem?.getAddress
        
        itemCell.commentCount.text = currentItem?.getCommentCount.description
        
        itemCell.layer.borderWidth = 9
        itemCell.layer.borderColor = UIColor.clear.cgColor
        itemCell.layer.cornerRadius = 7
        
        return itemCell
    }
    
    @objc func readHousingData(){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("housing")
        
        ref.observeSingleEvent(of: .value, with: {
            (snapshot) in
            self.houseList.clearList()
            for child in snapshot.children {
                let node = HousingDataStructures.Node()
                let keysnap = child as! DataSnapshot
                node.setKey(key: keysnap.key)
                for grandchild in (child as AnyObject).children {
                    let snap = grandchild as! DataSnapshot
                    let key = snap.key
                    let value = snap.value
                    switch key {
                    case "address":
                        node.setAddress(address: value! as! String)
                    case "description":
                        node.setDescription(description: value! as! String)
                    case "houseName":
                        node.setName(name: value! as! String)
                    case "posterName":
                        node.setPoster(person: value! as! String)
                    case "comments":
                        for _ in (grandchild as
                            AnyObject).children{
                                node.addCommentCount()
                        }
                    default:
                        print("do nothing")
                        //node.setDetail(detail: value! as! String)
                    }
                }
                print("\(node.getName) has \(node.getCommentCount) comments.")
                self.houseList.append(node: node)
            }
            self.itemCount = self.houseList.getCount()!
        })
        table.reloadData()
    }
    

    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        
        var currentItem = houseList.first
        
        var i = 0
        
        while i < indexPath.row {
            currentItem = currentItem?.next
            i += 1
        }
        selectedItem = currentItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var itemIndex = 0
        
        var itemNode: HousingDataStructures.Node = houseList.first!
        
        while(itemIndex < selected){
            itemIndex += 1
            itemNode = itemNode.next!
        }
        
        if let housingDetailTableViewController = segue.destination as? HousingDetailTableViewController {
            housingDetailTableViewController.data = itemNode
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector((readHousingData)), userInfo: nil, repeats: false)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        readHousingData()
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector((readHousingData)), userInfo: nil, repeats: false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
