//
//  Color.swift
//  MomsDayDaughter
//
//  Created by daeun on 29/11/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import Foundation
import UIKit

enum Color{
    
    case GREEN, LIGHTGREEN, GRAY
    
    func getColor() -> UIColor {
        switch self {
        case .GREEN:
            return UIColor(red: 171/255, green: 199/255, blue: 55/255, alpha: 1)
        case .LIGHTGREEN:
            return UIColor(red: 236/255, green: 236/255, blue: 208/255, alpha: 1)
        case .GRAY:
            return UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        }
    }
    
}
