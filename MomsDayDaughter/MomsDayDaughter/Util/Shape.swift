//
//  Shape.swift
//  MomsDayDaughter
//
//  Created by daeun on 28/11/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import Foundation
import UIKit

class WhiteButtonShape: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = frame.height/2
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
    }
    
}


class BottomBorderToolbar: UIToolbar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.clipsToBounds = true
        self.layer.addBottomBorderWithColor(color: Color.GRAY.getColor(), width: 1.0)
    }
}


extension CALayer {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width+100, height: width)
        self.addSublayer(border)
    }
}
