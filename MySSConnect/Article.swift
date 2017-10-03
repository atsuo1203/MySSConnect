//
//  Article.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class Article: NSObject {
    var id: Int
    var url: String
    var posted_at: String
    var blog: Blog
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.url = json["url"].description
        self.posted_at = json["posted_at"].description
        self.blog = Blog(json: json["blog"])
    }
}
