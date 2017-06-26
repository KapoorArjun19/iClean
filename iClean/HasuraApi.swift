//
//  HasuraApi.swift
//  iClean
//
//  Created by Arjun on 20/06/17.
//  Copyright © 2017 Arjun. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class HasuraApi
{
    static func makeAlamofireObjectCall<T: Mappable>(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        completionHandler: @escaping (DataResponse<T>) -> Void)
    {
        
        let headers: HTTPHeaders = [
            "Content-type": "application/json"
        ]
        
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseObject(completionHandler: completionHandler)
        debugPrint(request)
    }
    
    static func addUser(name: String, mobilenumber: String, latitude: String, longitude: String, image: String, completionHandler: @escaping (DataResponse<UserReturningResponse>) -> Void)
    {
        let params: [String: Any] = [
            "type" : "insert",
            "args" : [
                "table"     : "user",
                "objects"   : [
                    [
                        "name"    : name,
                        "mobile_number": mobilenumber,
                        "latitude": latitude,
                        "longitude": longitude,
                        "image": image
                    ]
                ],
                "returning" : ["id","name","mobile_number","latitude","longitude","image"]
            ]
        ]
        
        makeAlamofireObjectCall(Endpoint.QUERY,method: .post, parameters: params, completionHandler: completionHandler)
    }
    
}
