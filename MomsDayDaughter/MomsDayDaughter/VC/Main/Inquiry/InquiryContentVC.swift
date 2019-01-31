//
//  InquiryContentVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 24/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class InquiryContentVC: UIViewController,UITableViewDelegate {
    
    var id: String!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setDateLabel
        var date = Date()
        switch id {
        case "twoDaysAgo":
            date = Date(timeIntervalSinceNow: -(86400*2))
        case "yesterday":
            date = Date(timeIntervalSinceNow: -86400)
        default:
            date = Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.M.d"
        let dateString: String! = dateFormatter.string(from: date)
        dateLabel.text = dateString
    }
}
