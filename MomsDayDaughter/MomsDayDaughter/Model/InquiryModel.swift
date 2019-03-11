//
//  InquiryModel.swift
//  MomsDayDaughter
//
//  Created by daeun on 08/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import ObjectMapper

class InquiryModel: Mappable {
    
    var twoDaysAgo: InquiryContentModel?
    var yesterday: InquiryContentModel?
    var today: InquiryContentModel?
    
    required init?(map: Map) {    }
    
    func mapping(map: Map) {
        twoDaysAgo <- map["2days_ago"]
        yesterday <- map["yesterday"]
        today <- map["today"]
    }
    
    class InquiryContentModel: Mappable {
        
        var additional: AdditionalModel?
        var condition: [ConditionModel]?
        var date: String?
        var meal: MealModel?
        var photo: PhotoModel?
        var schedule: [ScheduleModel]?
        
        
        required init?(map: Map) {   }
        
        func mapping(map: Map) {
            additional <- map ["additional"]
            condition <- map ["condition"]
            date <- map["date"]
            meal <- map["meal"]
            photo <- map["photo"]
            schedule <- map["schedule"]
        }
        
        class AdditionalModel: Mappable {
            
            var description: String?
            
            required init?(map: Map) {    }
            func mapping(map: Map) {
                description <- map ["description"]
            }
        }
        
        class ConditionModel: Mappable {
            
            var activityReduction: Bool?
            var lowTemparature: Bool?
            var highFever: Bool?
            var bloodPressureincrease: Bool?
            var bloodPressureReduction: Bool?
            var lackOfSleep: Bool?
            var loseAppetite: Bool?
            var bingeEating: Bool?
            var diarrhea: Bool?
            var constipation: Bool?
            var vomiting: Bool?
            var urinationInconvenient: Bool?
            var humanPowerReduction: Bool?
            var povertyOfBlood: Bool?
            var cough: Bool?
            
            required init?(map: Map) {   }
            
            func mapping(map: Map) {
                activityReduction <- map["activity_reduction"]
                lowTemparature <- map["low_temperature"]
                highFever <- map["high_fever"]
                bloodPressureincrease <- map["blood_pressure_increase"]
                bloodPressureReduction <- map["blood_pressure_reduction"]
                lackOfSleep <- map["lack_of_sleep"]
                loseAppetite <- map["lose_Appetite"]
                bingeEating <- map["binge_eating"]
                diarrhea <- map["diarrhea"]
                constipation <- map["constipation"]
                vomiting <- map["vomiting"]
                urinationInconvenient <- map["urination_inconvenient"]
                humanPowerReduction <- map["human_power_reduction"]
                povertyOfBlood <- map["poverty_of_blood"]
                cough <- map["cough"]
            }
        }
        
        class MealModel: Mappable {
            
            var breakfast: [String]?
            var lunch: [String]?
            var dinner: [String]?
            var snack: String?
            
            required init?(map: Map) {   }
            
            func mapping(map: Map) {
                breakfast <- map["breakfast"]
                lunch <- map["lunch"]
                dinner <- map["dinner"]
                snack <- map["snack"]
            }
        }
        
        class PhotoModel: Mappable {
            
            var comment: String?
            var photoPath: String?
            
            required init?(map: Map) {   }
            
            func mapping(map: Map) {
                comment <- map["comment"]
                photoPath <- map["photo_path"]
            }
        }
        
        class ScheduleModel: Mappable {
            
            var time: String?
            var work: String?
            
            required init?(map: Map) {   }
            
            func mapping(map: Map) {
                time <- map["time"]
                work <- map["work"]
            }
        }
        
    }

}
