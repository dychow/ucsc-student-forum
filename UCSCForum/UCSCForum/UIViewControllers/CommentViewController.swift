//
//  CommentViewController.swift
//  UCSCForum
//
//  Created by Daniel Chow on 2/22/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import Foundation

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        return itemCell
    }
    
    
    var data: String? = ""
    var list = LinkedList()
    var itemIndex: Int = 0
    
    //for table use when displaying
    var itemCount: Int = 0
    
    //modified node for comments
    public class Node {
        private var posterName: String
        private var comment: String
        weak var prev: Node? = nil
        var next: Node? = nil
        
        public init() {
            self.posterName = ""
            self.comment = ""
        }
        
        public var getPoster: String {
            return self.posterName
        }
        
        public var getComment: String {
            return self.comment
        }
        
        
        public func setPoster(person: String){
            self.posterName = person
        }
        
        public func setComment(text: String){
            self.comment = text
        }

        
    }
    //modified linked list for comment nodes
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
                print(iterator!.getComment)
                
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
        }
    }
    
// Prints Comments, does not display yet
    @IBAction func displayComments(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("market").child(data!).child("comments")
        
        ref.observeSingleEvent(of: .value, with: {
            (snapshot) in
            self.list.clearList()
            for child in snapshot.children {
                let node = Node()
                let snap = child as! DataSnapshot
                self.itemIndex = Int(snap.key) as Int!
                for grandchild in (child as AnyObject).children {
                    let grandsnap = grandchild as! DataSnapshot
                    let key = grandsnap.key
                    let value = grandsnap.value
                    switch key {
                    case "name":
                        node.setPoster(person: value! as! String)
                    default:
                        node.setComment(text: value! as! String)
                    }
                }
                self.list.append(node: node)
            }
            
            self.itemCount = self.list.getCount()!
            
            self.list.printList()
        })
        
    }
    
    //comments don't load on view load, press button to load
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("comments page: \(String(describing: data))")

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
