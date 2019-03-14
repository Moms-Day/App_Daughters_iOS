//
//  RankInformVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 07/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyStarRatingView
import DLRadioButton

class HospitalInformVC: UIViewController {
    
    var facilityCode: String = ""
    var oneLineE: [String] = []
    @IBOutlet weak var holpitalNameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var scoreFacilityLabel: UILabel!
    @IBOutlet weak var scoreMealLabel: UILabel!
    @IBOutlet weak var scoreScheduleLabel: UILabel!
    @IBOutlet weak var scoreCostLabel: UILabel!
    @IBOutlet weak var scoreServiceLabel: UILabel!
    @IBOutlet weak var overallStarRatingView: SwiftyStarRatingView!
    @IBOutlet weak var oneLineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overallStarRatingView.isUserInteractionEnabled = false
        
        let url = "http://52.78.5.142/daughter/info/facility/\(facilityCode)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject {(response: DataResponse<HospitalInformModel>) in
            let model = response.result.value
            
            self.holpitalNameLabel.text = model?.name
            self.phoneNumLabel.text = model?.phoneNumber
            self.addressLabel.text = model?.address
            self.bioLabel.text = model?.bio
            self.scoreFacilityLabel.text = "\((model?.scoreFacility) ?? 0)점"
            self.scoreMealLabel.text = "\((model?.scoreMeal) ?? 0)점"
            self.scoreScheduleLabel.text = "\((model?.scoreSchedule) ?? 0)점"
            self.scoreCostLabel.text = "\((model?.scoreCost) ?? 0)점"
            self.scoreServiceLabel.text = "\((model?.scoreService) ?? 0)점"
            self.overallStarRatingView.value = CGFloat(model?.overall ?? 0)
            self.oneLineE = model?.oneLineE ?? [""]
            self.oneLineTableView.reloadData()
            
        }
    }
}

extension HospitalInformVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oneLineE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! reviewDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.oneLineText.text = oneLineE[indexPath.row]
        return cell
    }
}

internal class reviewDTO: UITableViewCell {
    @IBOutlet weak var oneLineText: UILabel!
}
