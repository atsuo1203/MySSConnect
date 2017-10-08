//
//  Story.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class Story: NSObject {
    var id: Int
    var title: String
    var first_posted_at: String
    var tag_list: [String]
    var articles: [Article]
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.first_posted_at = json["first_posted_at"].stringValue
        self.tag_list = json["tag_list"].arrayValue.map { $0.stringValue }
        self.articles = json["articles"].arrayValue.map { Article(json: $0) }
    }
    convenience override init() {
        self.init(json: JSON.init(""))
        self.id = 0
        self.title = ""
        self.first_posted_at = ""
        self.tag_list = [String]()
        self.articles = [Article]()
    }
}
