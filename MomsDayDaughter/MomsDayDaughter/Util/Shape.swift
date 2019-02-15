//
//  Shape.swift
//  MomsDayDaughter
//
//  Created by daeun on 28/11/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import Foundation
import UIKit
import SwiftyStarRatingView

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

class TopBorderButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.addTopBorderwithColor(color: Color.GREEN.getColor(), width: 1.0)
    }
}


extension CALayer {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width+100, height: width)
        self.addSublayer(border)
    }
    
    func addTopBorderwithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0, width: self.frame.size.width+100, height: width)
        self.addSublayer(border)
    }
}

class dynamicTableView: UITableView {
    var height: CGFloat = 0
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: height)
    }
}
