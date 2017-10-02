//
//  Story.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/02.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class Story: NSObject {
    var id = ""
    var title = ""
    var first_posted_at = ""
    var tag_list = [String]()
    var articles = [Article]()
}
