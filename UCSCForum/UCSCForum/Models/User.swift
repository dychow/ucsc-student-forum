//
//  User.swift
//  UCSCForum
//
//  Created by MacDouble on 3/4/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//
import Foundation
import FirebaseDatabase
import Firebase

struct user {
    
    let email:String!
    let key:String!
    let name: String!
    let profileImageUrl: String!
    
    let about:String!
    let ref: DatabaseReference?
    
    init(email: String, name: String,  about:String, profileImageUrl: String, key:String = ""){
        self.key = key
        self.name = name
        self.email = email
        self.about = about
        self.profileImageUrl = profileImageUrl
        self.ref = nil
    }
    
    init (snapshot:DataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
       
        if let nanaAddedBy = snapshot.value as? NSDictionary {
            about = nanaAddedBy["about"] as? String
        }else{
            about = ""
        }
        if let nanaTitle = snapshot.value as? NSDictionary {
            email = nanaTitle["email"] as? String
        }else{
            email = ""
        }
        if let nanaValue = snapshot.value as? NSDictionary {
            name = nanaValue["name"] as? String
        }else{
            name = ""
        }
        if let nanaValue = snapshot.value as? NSDictionary {
            profileImageUrl = nanaValue["profileImageUrl"] as? String
        }else{
            profileImageUrl = ""
        }
    }
    func toAnyObject() -> Any{
        return ["email": email, "name": name, "about": about, "profileImageUrl": profileImageUrl]
    }
    
}

