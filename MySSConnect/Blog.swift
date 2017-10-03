//
//  Blog.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class Blog: NSObject {
    var id = 0
    var title = ""
    var rss = ""
    var created_at = ""
    var updated_at = ""
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].description
        self.rss = json["rss"].description
        self.created_at = json["created_at"].description
        self.updated_at = json["updated_at"].description
    }
}
