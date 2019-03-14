//
//  HospitalInformModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 13/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class HospitalInformModel: Mappable {
    
    var address: String!
    var bio: String!
    var imagePath: String!
    var name: String!
    var oneLineE: [String]!
    var overall: Float!
    var phoneNumber: String!
    var scoreCost: Float!
    var scoreFacility: Float!
    var scoreMeal: Float!
    var scoreSchedule: Float!
    var scoreService: Float!
    
    required init?(map: Map) {    }
    
    func mapping(map: Map) {
        address <- map["address"]
        bio <- map["bio"]
        imagePath <- map["imagePath"]
        name <- map["name"]
        oneLineE <- map["oneLineE"]
        overall <- map["overall"]
        phoneNumber <- map["phoneNumber"]
        scoreCost <- map["scoreCost"]
        scoreFacility <- map["scoreFacility"]
        scoreMeal <- map["scoreMeal"]
        scoreSchedule <- map["scoreSchedule"]
        scoreService <- map["scoreService"]
    }
}
