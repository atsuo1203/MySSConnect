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
    var id: String?
    var title: String?
    var rss: String?
    var created_at: String?
    var updated_at: String?
    
    init(json: JSON) {
        self.id = json["id"].description
        self.title = json["title"].description
        self.rss = json["rss"].description
        self.created_at = json["created_at"].description
        self.updated_at = json["updated_at"].description
    }
}
