//
//  API.swift
//  MySSConnect
//
//  Created by Atsuo Yonehara on 2017/10/01.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SafariServices

class API {
    
    static let baseURL = "https://ssconnect.elzup.com/v1/"
    
    static func getStories() -> DataRequest {
        let url = baseURL + "stories"
        let response = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        return response
    }
    
    static func getStories(tag: String, q: String, page: String) -> DataRequest {
        let url = baseURL+"stories"+"?tag="+tag+"&q="+q+"&page="+page
        let encURL = NSURL(string:url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let response = Alamofire.request(encURL!.description, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        return response
    }
    
    static func getTags() -> DataRequest {
        let url = baseURL + "tags"
        let response = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        return response
    }
    
    static func getBlog() -> DataRequest {
        let url = baseURL + "blogs"
        let response = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        return response
    }
    
    static func showWebView(viewController: AnyObject, targetURL: String) {
        let url = URL(string: targetURL)!
        let webView = SFSafariViewController(url: url)
        viewController.present(webView, animated: true, completion: nil)
    }

}
