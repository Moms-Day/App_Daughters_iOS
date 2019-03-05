//
//  LoginModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 05/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginModel: Mappable {
    var accessToken: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        accessToken <- map["accessToken"]
    }
}
