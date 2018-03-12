//
//  MyPostsTableViewController.swift
//  UCSCForum
//
//  Created by Bond on 2018/3/8.
//  Copyright © 2018年 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class MyPostsTableViewController: UITableViewController {

    var selected: Int = 0
    var selectedItem: Node?
    var itemCount: Int = 0
    var list = LinkedList()
    var houseList = HousingDataStructures.LinkedList()
    
    @IBOutlet weak var table: UITableView!
    
    public class Node {
        private var profileImage: String
        private var contentImage: String
        private var posterName: String
        private var itemAddress: String
        private var itemCategory: String
        private var itemDelivery: Bool
        private var itemDetail: String
        private var itemName: String
        private var itemKey: String
        private var commentCount: Int
        weak var prev: Node? = nil
        var next: Node? = nil
        
        public init() {
            self.profileImage = ""
            self.contentImage = ""
            self.posterName = ""
            self.itemAddress = ""
            self.itemCategory = ""
            self.itemDelivery = false
            self.itemDetail = ""
            self.itemName = ""
            self.itemKey = ""
            self.commentCount = -1
        }
        
        public var getProfileImage: String {
            return self.profileImage
        }
        public var getContentImage: String {
            return self.contentImage
        }
        public var getPoster: String {
            return self.posterName
        }
        
        public var getAddress: String {
            return self.itemAddress
        }
        
        public var getCategory: String {
            return self.itemCategory
        }
        
        public var getDelivery: Bool {
            return self.itemDelivery
        }
        
        public var getDetail: String {
            return self.itemDetail
        }
        
        public var getName: String {
            return self.itemName
        }
        
        public var getKey: String {
            return self.itemKey
        }
        
        public var getCommentCount : Int {
            return self.commentCount
        }
        
        public func setPoster(person: String){
            self.posterName = person
        }
        
        public func setAddress(address: String){
            self.itemAddress = address
        }
        
        public func setCategory(category: String){
            self.itemCategory = category
        }
        
        public func setDelivery(delivery: Bool){
            self.itemDelivery = delivery
        }
        
        public func setDetail(detail: String){
            self.itemDetail = detail
        }
        
        public func setName(name: String){
            self.itemName = name
        }
        
        public func setKey(key: String){
            self.itemKey = key
        }
        
        public func addCommentCount() {
            self.commentCount = self.commentCount + 1
        }
        
    }
    
    public class LinkedList {
        fileprivate var head: Node?
        private var tail: Node?
        private var cur: Node?
        private var count: Int? = 0
        
        public var isEmpty: Bool {
            return head == nil
        }
        
        public var first: Node? {
            return head
        }
        
        public var last: Node? {
            return tail
        }
        
        public var current: Node? {
            return cur
        }
        
        public var counter: Int? {
            return count
        }
        
        public func append(node: Node) {
            count = count! + 1
            if let tailNode = tail {
                node.prev = tailNode
                tailNode.next = node
            }
            else {
                head = node
            }
            tail = node
        }
        
        public func delete(node: Node) {
            count = count! - 1
            let prev = node.prev
            let next = node.next
            
            if let prev = prev {
                prev.next = next
            } else {
                head = next
            }
            next?.prev = prev
            
            node.prev = nil
            node.next = nil
        }
        
        
        public func printList() {
            var iterator = first
            while iterator != nil {
                print(iterator!.getPoster)
                print(iterator!.getName)
                print(iterator!.getAddress)
                print(iterator!.getCategory)
                print(iterator!.getDelivery)
                print(iterator!.getDetail)
                print(iterator!.getKey)
                
                iterator = iterator?.next
            }
        }
        
        public func clearList() {
            head = nil
            tail = nil
            count = 0
        }
        
        public func getCount() -> Int? {
            var iterator = first
            var itemCount: Int = 0
            while iterator != nil {
                itemCount += 1
                iterator = iterator?.next
            }
            return itemCount
            //            return count
        }
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
                if(Auth.auth().currentUser?.uid == node.getPoster){
                    self.houseList.append(node: node)
                }
            }
            self.itemCount = self.houseList.getCount()!
        })

        //table.reloadData()
    //}
    
    //@objc public func reloadTable() {
        //var ref: DatabaseReference!
        ref = Database.database().reference().child("market")
        
        ref.observeSingleEvent(of: .value, with: {
            (snapshot) in
            self.list.clearList()
            for child in snapshot.children {
                let node = Node()
                let keysnap = child as! DataSnapshot
                node.setKey(key: keysnap.key)
                for grandchild in (child as AnyObject).children {
                    let snap = grandchild as! DataSnapshot
                    let key = snap.key
                    let value = snap.value
                    switch key {
                    case "posterName":
                        node.setPoster(person: value! as! String)
                    case "itemName":
                        node.setName(name: value! as! String)
                    case "itemAddress":
                        node.setAddress(address: value! as! String)
                    case "itemCategory":
                        node.setCategory(category: value! as! String)
                    case "itemDelivery":
                        node.setDelivery(delivery: value! as! Bool)
                    case "comments":
                        for _ in (grandchild as
                            AnyObject).children{
                                node.addCommentCount()
                        }
                    default:
                        node.setDetail(detail: value! as! String)
                    }
                }
                print("\(node.getName) has \(node.getCommentCount) comments.")
                if(Auth.auth().currentUser?.uid == node.getPoster){
                    self.list.append(node: node)
                }
            }
            
            self.itemCount = self.list.getCount()!
        })
        table.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseList.getCount()! + list.getCount()!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        if indexPath.row < list.getCount()! {
            var currentItem = list.first
            
            var i = 0
            
            while i < indexPath.row {
                currentItem = currentItem?.next
                i += 1
            }
            
            itemCell.personName.text = currentItem?.getPoster
            
            itemCell.itemNameTextField.text = currentItem?.getName
            
            itemCell.itemDetailTextField.text = currentItem?.getDetail
            
            itemCell.commentCount.text = currentItem?.getCommentCount.description
            
            itemCell.layer.borderWidth = 9
            itemCell.layer.borderColor = UIColor.clear.cgColor
            itemCell.layer.cornerRadius = 7
            
            return itemCell
            
        } else {
            var currentItem = houseList.first
        
            var i = 0
        
            while i < (indexPath.row - list.getCount()!) {
                currentItem = currentItem?.next
                i += 1
            }
        
            itemCell.personName.text = currentItem?.getPoster
            
            itemCell.itemNameTextField.text = currentItem?.getName
            
            itemCell.itemDetailTextField.text = currentItem?.getDescription
            
            itemCell.commentCount.text = currentItem?.getCommentCount.description
            
            itemCell.layer.borderWidth = 9
            itemCell.layer.borderColor = UIColor.clear.cgColor
            itemCell.layer.cornerRadius = 7
            
            return itemCell
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
