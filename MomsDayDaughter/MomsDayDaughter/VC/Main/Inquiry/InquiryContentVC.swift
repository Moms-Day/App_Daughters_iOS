//
//  InquiryContentVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 24/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import AlamofireImage

class InquiryContentVC: UIViewController {
    
    var id: String!
    var conditions = ["활동량 감소", "저체온", "고열","고혈압","저혈압","수면 부족","식욕 감퇴","폭식","설사","변비","구토","배뇨활동 불편","인지력 감퇴","빈혈","기침"]
    var conditionBool: [Bool] = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    @IBOutlet weak var scheduleTable: dynamicTableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var lunchLabel: UILabel!
    @IBOutlet weak var dinnerLabel: UILabel!
    @IBOutlet weak var snackLabel: UILabel!
    @IBOutlet weak var additionalDescriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoComentLabel: UILabel!
    @IBOutlet weak var conditionCollectionView: UICollectionView!
    
    var scheduleList: [Schedule]? = []
    var breakfastText: String = ""
    var lunchText: String = ""
    var dinnerText: String = ""
    var snackText: String = ""
    var additionalDescriptionText: String = ""
    var photoPathText: String = ""
    var photoCommentText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTable.height = CGFloat((50*(scheduleList?.count ?? 1)))
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
        breakfastLabel.text = breakfastText
        lunchLabel.text = lunchText
        dinnerLabel.text = dinnerText
        snackLabel.text = snackText
        additionalDescriptionLabel.text = additionalDescriptionText
        photoComentLabel.text = photoCommentText
        scheduleTable.reloadData()
        setPhoto(photoPath: photoPathText)
        conditionCollectionView.reloadData()
    }
    
    func addSchedule(time: String, work: String) {
        scheduleList?.append(Schedule(time: time, work: work))
    }
    
    func setInquiry(date: String?, breakfastMeal: [String], lunchMeal: [String], dinnerMeal: [String], snack: String,additionalDescription: String, photoPath: String, photoComent: String) {
        
        breakfastText = ""
        lunchText = ""
        dinnerText = ""
        
        for i in breakfastMeal.indices {
            breakfastText.append(contentsOf: breakfastMeal[i])
        }
        for i in lunchMeal.indices {
            lunchText.append(contentsOf: lunchMeal[i])
        }
        for i in dinnerMeal.indices {
            dinnerText.append(contentsOf: dinnerMeal[i])
        }
        
        snackText = snack
        additionalDescriptionText = additionalDescription
        photoPathText = photoPath
        photoCommentText = photoComent
    }
    
    func setPhoto(photoPath: String) {
        if photoPath != "" {
            let imageCache = AutoPurgingImageCache()
            
            let urlRequest = URLRequest(url: URL(string: photoPath)!)
            let photoImage = UIImage(named: "photo")
            
            imageCache.add(photoImage!, for: urlRequest, withIdentifier: "photo")
        }
    }
}

extension InquiryContentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (scheduleList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell") as! scheduleDTO
        cell.timeLabel.text = scheduleList![indexPath.row].time
        cell.scheduleLabel.text = scheduleList![indexPath.row].work
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
        if conditionBool[indexPath.row] == true {
            cell.conditionImage.image = UIImage(named: "radio_on")
        }
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

internal class Schedule {
    var time: String
    var work: String
    
    init(time: String, work: String) {
        self.time = time
        self.work = work
    }
}

