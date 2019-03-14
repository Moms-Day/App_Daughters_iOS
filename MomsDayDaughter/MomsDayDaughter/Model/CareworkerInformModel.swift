//
//  CareworkerInformModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 13/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class CareworkerInformModel: Mappable {

    var bio: String!
    var career: Int!
    var imagePath: String!
    var name: String!
    var oneLineE: [String]!
    var overall: Float!
    var patientInCharge: Int!
    var scoreDiligence: Float!
    var scoreKindness: Float!
    var workplace: String!
    
    required init?(map: Map) {    }
    
    func mapping(map: Map) {
        bio <- map["bio"]
        career <- map["career"]
        imagePath <- map["imagePath"]
        name <- map["name"]
        oneLineE <- map["oneLineE"]
        overall <- map["overall"]
        patientInCharge <- map["patientInCharge"]
        scoreDiligence <- map["scoreDiligence"]
        scoreKindness <- map["scoreKindness"]
        workplace <- map["workplace"]
    }
}
