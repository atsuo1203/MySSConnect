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

class API {
    
    static let baseURL = "https://ssconnect.elzup.com/v1/stories"
    
    static func getRequest() -> DataRequest {
        let response = Alamofire.request(baseURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        print(response)
        return response
    }
    
    static func postRequest(name: String, description: String){
        let parameters: Parameters = [
            "name": name,
            "description": description
        ]
        Alamofire.request(baseURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
        }
    }
    
    static func putRequest(userID: String, name: String, description: String) {
        let parameters: Parameters = [
            "name": name,
            "description": description
        ]
        Alamofire.request(baseURL + userID, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
        }
    }
    
    static func deleteRequest(userID: String) {
        Alamofire.request(baseURL + userID, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
        }
    }
}
