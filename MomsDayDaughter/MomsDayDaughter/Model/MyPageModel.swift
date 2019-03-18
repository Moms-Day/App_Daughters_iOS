//
//  MyPageModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 18/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class MyPageModel: Mappable {
    
    var age: Int?
    var name: String?
    var patients: [Patients]?
    
    required init?(map: Map) {    }
    
    func mapping(map: Map) {
        age <- map["age"]
        name <- map["name"]
        patients <- map["patients"]
    }
    
    class Patients: Mappable {
        var age: Int?
        var gender: Bool?
        var name: String?
        
        required init?(map: Map) {    }
        
        func mapping(map: Map) {
            age <- map["age"]
            gender <- map["gender"]
            name <- map["name"]
        }
    }
}
