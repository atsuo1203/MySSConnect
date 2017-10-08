//
//  RealmStory.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/08.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import RealmSwift

class RealmStory: Object {
    dynamic var id = 0
    dynamic var story = Story()
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    static func create(story: Story) -> RealmStory {
        let realmStory = RealmStory()
        realmStory.id = story.id
        realmStory.story = story
        return realmStory
    }
    
    func put() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    static func getAll() -> [RealmStory] {
        let realm = try! Realm()
        let stories = realm.objects(self)
        return stories.map { $0 }
    }
    
    static func addStory(story: Story){
        let stories = getAll()
        stories.forEach { (realmStory) in
            if realmStory.id != story.id {
                create(story: story).put()
            }
        }
    }
}
