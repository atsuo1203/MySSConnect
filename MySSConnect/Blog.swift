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
    var id: Int
    var title: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].description
    }
}
