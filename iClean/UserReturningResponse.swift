//
//  UserReturningResponse.swift
//  iClean
//
//  Created by Arjun on 20/06/17.
//  Copyright © 2017 Arjun. All rights reserved.
//

import ObjectMapper

class UserReturningResponse: Mappable
{
    var affectedRows: Int?
    var returning: [UserRecord]?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map)
    {
        affectedRows <- map["affected_rows"]
        returning <- map["returning"]
    }
}
