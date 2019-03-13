//
//  CareworkerRankModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 12/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class CareworkerRankModel: Mappable {
    
    var careworkerRanking: [Careworker]?
    var myCareworker: [Careworker]?
    
    required init?(map: Map) {    }
    
    func mapping(map: Map) {
        careworkerRanking <- map["careWorkerRanking"]
        myCareworker <- map["myCareWorkers"]
    }
    
    class Careworker: Mappable {
        
        var careworkerId: String?
        var career: Int?
        var imagePath: String?
        var name: String?
        var overall: Float?
        var patientInCharge: Int?
        var workplace: String?
        
        required init?(map: Map) {    }
        
        func mapping(map: Map) {
            careworkerId <- map["careWorkerId"]
            career <- map["career"]
            imagePath <- map["imagePath"]
            name <- map["name"]
            overall <- map["overall"]
            patientInCharge <- map["patientInCharge"]
            workplace <- map["workplace"]
        }
    }
}
