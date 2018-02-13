//
//  FirstViewController.swift
//  UCSCForum
//
//  Created by MacDouble on 1/20/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public class Node {
        private var itemAddress: String
        private var itemCategory: String
        private var itemDelivery: Bool
        private var itemDetail: String
        private var itemName: String
        weak var prev: Node? = nil
        var next: Node? = nil
        
        public init() {
            self.itemAddress = ""
            self.itemCategory = ""
            self.itemDelivery = false
            self.itemDetail = ""
            self.itemName = ""
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
                print(iterator!.getName)
                print(iterator!.getAddress)
                print(iterator!.getCategory)
                print(iterator!.getDelivery)
                print(iterator!.getDetail)
                
                iterator = iterator?.next
            }
        }
        
    }
    
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
        ref = Database.database().reference().child("market")
        
        ref.observeSingleEvent(of: .value, with: {
            (snapshot) in
            let list = LinkedList()
            for child in snapshot.children {
                let node = Node()
                for grandchild in (child as AnyObject).children {
                    let snap = grandchild as! DataSnapshot
                    let key = snap.key
                    let value = snap.value
                    switch key {
                    case "itemName":
                        node.setName(name: value! as! String)
                    case "itemAddress":
                        node.setAddress(address: value! as! String)
                    case "itemCategory":
                        node.setCategory(category: value! as! String)
                    case "itemDelivery":
                        node.setDelivery(delivery: value! as! Bool)
                    default:
                        node.setDetail(detail: value! as! String)
                    }
                }
                list.append(node: node)
            }
            list.printList()
        })
        

         // ref.observeSingleEvent(of: .value, with: {
         //   (snapshot) in
            
         //   if !snapshot.exists() {return}
            
          //  let value = snapshot.value as? NSString
            
           // let string = value as! String
            
         //   ref.setValue(Int(string)!+1)

       // })

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

