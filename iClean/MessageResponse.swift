//
//  MessageResponse.swift
//  iClean
//
//  Created by Arjun on 20/06/17.
//  Copyright © 2017 Arjun. All rights reserved.
//

import ObjectMapper

class MessageResponse: Mappable
{
    
    var message: String!
    
    required init?(map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        message <- map["message"]
    }
}
