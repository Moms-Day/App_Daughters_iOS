//
//  InquiryContentVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 24/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class InquiryContentVC: UIViewController {
    
    var id: String!
    @IBOutlet weak var scheduleTable: scheduleTableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTable.height = (50*5)
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

extension InquiryContentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell") as! scheduleDTO
        cell.scheduleLabel.text = "adf"
        return cell
    }
    
}

internal class scheduleDTO: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
}

internal class scheduleTableView: UITableView {
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
