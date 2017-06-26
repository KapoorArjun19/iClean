//
//  UserRecord.swift
//  iClean
//
//  Created by Arjun on 20/06/17.
//  Copyright © 2017 Arjun. All rights reserved.
//

import ObjectMapper

class UserRecord: Mappable
{
    var id: Int!
    var name: String!
    var mobilenumber: String!
    var latitude: String!
    var longitude: String!
    var image: String!
    
    required init?(map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        id <- map["id"]
        name <- map["name"]
        mobilenumber <- map["mobile_number"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        image <- map["image"]
    }
}
