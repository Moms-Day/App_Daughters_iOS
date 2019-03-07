//
//  MainModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 07/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class MainModel: Mappable {

    var careId: String!
    var careName: String!
    var facilityCode: String!
    var facilityName: String!
    var id: String!
    var name: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        careId <- map["careId"]
        careName <- map["careName"]
        facilityCode <- map["facilityCode"]
        facilityName <- map["facilityName"]
        id <- map["id"]
        name <- map["name"]
    }
}
