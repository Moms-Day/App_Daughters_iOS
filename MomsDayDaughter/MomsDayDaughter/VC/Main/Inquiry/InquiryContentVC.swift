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
    let conditions = ["활동량 감소", "저체온", "고열","고혈압","저혈압","수면 부족","식욕 감퇴","폭식","설사","변비","구토","배뇨활동 불편","인지력 감퇴","빈혈","기침"]
    @IBOutlet weak var scheduleTable: dynamicTableView!
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
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

internal class scheduleDTO: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
}

extension InquiryContentVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conditions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conditionCell", for: indexPath) as! conditionCell
        cell.conditionLabel.text = conditions[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

internal class conditionCell: UICollectionViewCell {
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    
}
