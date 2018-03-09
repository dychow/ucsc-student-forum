//
//  CategoryViewController.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 2/19/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var category = ["Books", "Movies, Music & Games", "Electronics, Computers & Office", "Home, Garden, Pets & Tools", "Food & Grocery", "Beauty, Health & Household", "Toys, Kids & Baby", "Clothing, Shoes & Jewelry", "Handmade", "Sports & Outdoors"]
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return category.count
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        
        cell.textLabel?.text = category[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(category[indexPath.row], forKey: "categorySelected")
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
