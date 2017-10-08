//
//  RealmStory.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/08.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import RealmSwift

class RealmString: Object {
    // "1,http://hogehoge" みたいな要素を入れる予定
    dynamic var blogIDAndUrl = ""
}

class RealmStory: Object {
    dynamic var story_id = 0
    dynamic var title = ""
    dynamic var url = ""
    dynamic var blog_name = ""
    dynamic var data = ""
    
    //urlの配列を作るために必要
    var blogAndUrls: [String] {
        get {
            return _backingClipKeys.map { $0.blogIDAndUrl }
        }
        set {
            _backingClipKeys.removeAll()
            _backingClipKeys.append(objectsIn: newValue.map { RealmString(value: [$0]) })}
    }
    let _backingClipKeys = List<RealmString>()
    
    override static func ignoredProperties() -> [String] {
        return ["blogAndUrls"]
    }
    
    override class func primaryKey() -> String {
        return "story_id"
    }
    
    static func create(story: Story) -> RealmStory {
        let realmStory = RealmStory()
        realmStory.story_id = story.id
        realmStory.title = story.title
        realmStory.blogAndUrls = story.articles.map { $0.blog.id.description + "," + $0.blog.title + "," + $0.url }
        realmStory.url = story.articles[0].url
        realmStory.blog_name = story.articles[0].blog.title
        realmStory.data = story.first_posted_at.components(separatedBy: "T").first!
        return realmStory
    }
    
    func put() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    static func getRealmStory(id: Int) -> RealmStory {
        let realm = try! Realm()
        return realm.object(ofType: self, forPrimaryKey: id)!
    }
    
    static func getAll() -> [RealmStory] {
        let realm = try! Realm()
        let stories = realm.objects(self)
        return stories.map{ $0 }
    }
    
    static func getAllFilterBlogID() -> [RealmStory] {
        let stories = getAll()
        let blog_id = RealmBlog.getID(name: "realm")
        stories.forEach { (realmStory) in
            realmStory.blogAndUrls.forEach({ (blogIDAndUrl) in
                let param = blogIDAndUrl.components(separatedBy: ",")
                let id = param[0]
                if id == blog_id.description {
                    updateURLAndBlog(id: realmStory.story_id, url: param[2], blog_name: param[1])
                }
            })
        }
        return getAll()
    }
    
    static func addStory(story: Story){
        create(story: story).put()
    }
    
    static func updateURLAndBlog(id: Int, url: String, blog_name: String){
        let realm = try! Realm()
        try! realm.write {
            getRealmStory(id: id).url = url
            getRealmStory(id: id).blog_name = blog_name
        }
    }
    
    static func delete(entry: RealmStory) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(entry)
        }
    }
    
    static func deleteAll(){
        getAll().forEach {
            delete(entry: $0)
        }
    }
}
