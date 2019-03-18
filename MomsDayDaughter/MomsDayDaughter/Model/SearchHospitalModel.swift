//
//  SearchHospitalModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 18/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchHospitalModel: Mappable {
    
    var address: String?
    var careworkers: [Careworker]?
    var facilityCode: String?
    var name: String?
        
    required init?(map: Map) {    }
        
    func mapping(map: Map) {
        address <- map["address"]
        careworkers <- map["careWorkers"]
        facilityCode <- map["facilityCode"]
        name <- map["name"]
    }
        
    class Careworker: Mappable {
        
        var id: String?
        var name: String?
        
        required init?(map: Map) {            }
        
        func mapping(map: Map) {
            id <- map["id"]
            name <- map["name"]
        }
    }
}
