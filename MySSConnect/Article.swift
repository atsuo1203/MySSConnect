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
    var blog: Blog
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.url = json["url"].stringValue
        self.blog = Blog(json: json["blog"])
    }
}
