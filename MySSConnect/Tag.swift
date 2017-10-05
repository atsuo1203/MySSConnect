//
//  Tag.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/05.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SwiftyJSON

class Tag: NSObject {
    var id: Int
    var name: String
    var taggings_count: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.taggings_count = json["taggings_count"].intValue
    }
}
