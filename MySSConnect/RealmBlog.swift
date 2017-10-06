//
//  RealmBlog.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/07.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import RealmSwift

//class RealmInt: Object {
//    dynamic var intValue = 0
//}

class RealmBlog: Object {
    dynamic var key = ""
    dynamic var id = 0
//    var blogIDs: [Int] {
//        get {
//            return _backingClipKeys.map { $0.intValue }
//        }
//        set {
//            _backingClipKeys.removeAll()
//            _backingClipKeys.append(objectsIn: newValue.map { RealmInt(value: [$0]) })}
//    }
//    let _backingClipKeys = List<RealmInt>()
//    
//    override static func ignoredProperties() -> [String] {
//        return ["blogIDs"]
//    }
    
    override class func primaryKey() -> String {
        return "key"
    }
    
    static func create(name: String) -> RealmBlog {
        let realmBlog = RealmBlog()
        realmBlog.key = name
        realmBlog.id = 0
        return realmBlog
    }
    
    func put() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    static func getRealmBlog(name: String) -> RealmBlog {
        let realm = try! Realm()
        return realm.object(ofType: self, forPrimaryKey: name)!
    }
    
    static func getRealmBlogCount() -> Int {
        let realm = try! Realm()
        return realm.objects(self).count
    }
    
    static func updateBlogID(name: String, id:Int){
        let realm = try! Realm()
        let realmBlog = getRealmBlog(name: name)
        try! realm.write {
            realmBlog.id = id
        }
    }
    
    static func getID(name: String) -> Int {
        let realmBlog = getRealmBlog(name: name)
        return realmBlog.id
    }
}
