//
//  HousingDataStructures.swift
//  UCSCForum
//
//  Created by Jason Di Chen on 3/11/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import Foundation

class HousingDataStructures{
    public class Node {
        private var posterName: String
        private var commentCount: Int
        private var houseName: String
        private var houseKey: String
        private var houseAddress: String
        private var houseDescription: String
        private var seekHouse: Bool
        private var seekPeople: Bool
        weak var prev: Node? = nil
        var next: Node? = nil
        
        public init() {
            
            self.posterName = ""
            self.commentCount = -1
            self.houseName = ""
            self.houseKey = ""
            self.houseAddress = ""
            self.houseDescription = ""
            self.seekHouse = false
            self.seekPeople = false
        }
        
        public var getPoster: String {
            return self.posterName
        }
        
        public var getName: String {
            return self.houseName
        }
        
        public var getAddress: String {
            return self.houseAddress
        }
        
        public var getDescription: String {
            return self.houseDescription
        }
        
        public var getSeekHouse: Bool {
            return self.seekHouse
        }
        
        public var getSeekPeople: Bool {
            return self.seekPeople
        }
        
        public var getKey: String {
            return self.houseKey
        }
        
        public var getCommentCount : Int {
            return self.commentCount
        }
        
        public func setPoster(person: String){
            self.posterName = person
        }
        
        public func setName(name: String){
            self.houseName = name
        }
        
        public func setAddress(address: String){
            self.houseAddress = address
        }
        
        public func setDescription(description: String){
            self.houseDescription = description
        }
        
        public func setSeekHouse(seekHouse: Bool){
            self.seekHouse = seekHouse
        }
        
        public func setSeekPeople(seekPeople: Bool){
            self.seekPeople = seekPeople
        }
        
        public func setKey(key: String){
            self.houseKey = key
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
                print(iterator!.getDescription)
                print(iterator!.getAddress)
                print(iterator!.getSeekPeople)
                print(iterator!.getSeekHouse)
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
        }
    }
    
    
}
