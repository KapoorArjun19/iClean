//
//  Endpoint.swift
//  iClean
//
//  Created by Arjun on 20/06/17.
//  Copyright © 2017 Arjun. All rights reserved.
//

import Foundation

struct Endpoint
{

    private static let DB = "http://data.vcap.me"
    private static let VERSION = "v1"

    static let QUERY = Endpoint.DB + "/" + Endpoint.VERSION + "/query"
}
