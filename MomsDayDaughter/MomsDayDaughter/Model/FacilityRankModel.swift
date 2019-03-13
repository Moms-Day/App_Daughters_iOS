//
//  RankModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 11/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class FacilityRankModel: Mappable {
    var facilityRanking: [Facility]?
    var myFacility: [Facility]?
    
    required init?(map: Map) {    }
    
    func mapping(map: Map) {
        facilityRanking <- map["facilityRanking"]
        myFacility <- map["myFacilities"]
    }
    
    class Facility: Mappable {
        
        var address: String?
        var facilityCode: String?
        var imagePath: String?
        var medals: [String]?
        var name: String?
        var overall: Float?
        
        required init?(map: Map) {    }
        
        func mapping(map: Map) {
            address <- map["address"]
            facilityCode <- map["facilityCode"]
            imagePath <- map["imagePath"]
            medals <- map["medals"]
            name <- map["name"]
            overall <- map["overall"]
        }
    }
}
