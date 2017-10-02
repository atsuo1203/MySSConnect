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
    var id: String?
    var title: String?
    var first_posted_at: String?
    var tag_list: [String]?
    var articles: [Article]?
    
    init(json: JSON) {
        self.id = json["id"].description
        self.title = json["title"].description
        self.first_posted_at = json["first_posted_at"].description
        for i in 0..<json["tag_list"].count {
           self.tag_list?.append(json["tag_list"][i].description)
        }
        var list = [Article]()
        json.forEach { (string, json) in
            let article = Article(json: json)
            list.append(article)
        }
        self.articles = list
    }
}
