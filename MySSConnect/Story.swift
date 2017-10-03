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
    var id = 0
    var title = ""
    var first_posted_at = ""
    var tag_list = [String]()
    var articles = [Article]()
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].description
        self.first_posted_at = json["first_posted_at"].description
        for tag in json["tag_list"].arrayValue {
            self.tag_list.append(tag.stringValue)
        }
        var list = [Article]()
        json.forEach { (string, json) in
            let article = Article(json: json)
            list.append(article)
        }
        self.articles = list
    }
}
