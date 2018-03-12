//
//  HousingDetailTableViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase

class HousingDetailTableViewController: UITableViewController {

    var data: HousingDataStructures.Node?
    
    @IBOutlet var table: UITableView!
    
    var commentList = CommentViewController.LinkedList()
    
    @IBOutlet weak var posterName: UILabel!

    @IBOutlet weak var houseInfo: UILabel!
    
    @IBOutlet weak var houseAddress: UILabel!
    
    @IBOutlet weak var houseDetail: UILabel!
    
    @IBAction func addressPressed(_ sender: Any) {
        performSegue(withIdentifier: "HousingMap", sender: HousingDetailTableViewController())
    }
    
    @IBAction func makeCommentButtonPushed(_ sender: Any) {
        performSegue(withIdentifier: "HousingComment", sender: HousingDetailTableViewController())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let housingNewCommentViewController = segue.destination as? HousingNewCommentViewController {
            housingNewCommentViewController.dataNode = data
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector((reloadComments)), userInfo: nil, repeats: false)
        reloadComments()
        
        print("this is commentlist inside of housing detail")
        commentList.printList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterName.text = data?.getPoster
        
        houseInfo.text = data?.getName
        
        houseAddress.text = data?.getAddress
        
        houseDetail.text = data?.getDescription
        
        var houseAddressHeight = houseAddress.optimalHeight
        houseAddress.frame = CGRect(x:houseAddress.frame.origin.x, y:houseAddress.frame.origin.y, width: houseAddress.frame.width, height: houseAddressHeight)
        houseAddress.numberOfLines = 0
        
        var houseDetailHeight = houseDetail.optimalHeight
        houseAddress.frame = CGRect(x:houseDetail.frame.origin.x, y:houseDetail.frame.origin.y, width: houseDetail.frame.width, height: houseDetailHeight)
        houseDetail.numberOfLines = 0
        
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector((reloadComments)), userInfo: nil, repeats: false)
        
        reloadComments()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @objc func reloadComments(){

        var ref: DatabaseReference!
        ref = Database.database().reference().child("housing").child((data?.getKey)!).child("comments")
        
        
        
        ref.observeSingleEvent(of: .value, with: {
            (snapshot) in
            self.commentList.clearList()
            for child in snapshot.children {
                let node = CommentViewController.Node()
                //                let snap = child as! DataSnapshot
                //self.itemIndex = Int(snap.key) as Int!  //for making sure comments are in order
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
                
                self.commentList.append(node: node)
            }

            self.commentList.printList()
        })
        
        table.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentList.getCount()!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! CommentTableViewCell
        
        var iterator = commentList.first
        iterator = iterator?.next
        var i = 1
        while i < indexPath.row {
            iterator = iterator?.next
            i = i + 1
        }
        
        detailCell.commenterNameTextField?.text = iterator?.getPoster
        detailCell.commentDetailTextField?.text = iterator?.getComment
        
        var itemCommentHeight = detailCell.commentDetailTextField.optimalHeight
        
        detailCell.commentDetailTextField.frame = CGRect(x:detailCell.commentDetailTextField.frame.origin.x, y:detailCell.commentDetailTextField.frame.origin.y, width: detailCell.commentDetailTextField.frame.width, height: itemCommentHeight)
        
        detailCell.commentDetailTextField.numberOfLines = 0
        detailCell.layer.borderWidth = 9
        detailCell.layer.borderColor = UIColor.clear.cgColor
        detailCell.layer.cornerRadius = 7
        
        return detailCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
