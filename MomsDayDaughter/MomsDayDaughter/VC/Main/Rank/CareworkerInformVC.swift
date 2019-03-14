//
//  CareworkerInformVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 03/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyStarRatingView

class CareworkerInformVC: UIViewController {
    
    var careId: String = ""
    var oneLineE: [String] = []
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var diligenceLabel: UILabel!
    @IBOutlet weak var kindnessLabel: UILabel!
    @IBOutlet weak var totalStarRatingView: SwiftyStarRatingView!
    @IBOutlet weak var oneLIneTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalStarRatingView.isUserInteractionEnabled = false
        
        let url = "http://52.78.5.142/daughter/info/care_worker/\(careId)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject {(response: DataResponse<CareworkerInformModel>) in
            
            if response.response?.statusCode == 200 {
                let model = response.result.value
                
                self.nameLabel.text = model?.name
                self.workplaceLabel.text = model?.workplace
                self.careerLabel.text = "맡은 환자 수 : \((model?.patientInCharge)!)명   경력 : \((model?.career)!)년"
                self.bioLabel.text = model?.bio
                self.diligenceLabel.text = "\((model?.scoreDiligence)!)점"
                self.kindnessLabel.text = "\((model?.scoreKindness)!)점"
                self.totalStarRatingView.value = CGFloat(model?.overall ?? 0)
                self.oneLineE = model?.oneLineE ?? [""]
                self.oneLIneTableView.reloadData()
            } else {
                let alert = UIAlertController(title: "오류", message: "\((response.response?.statusCode)!)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension CareworkerInformVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oneLineE.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! careworkerReviewDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.oneLineText.text = oneLineE[indexPath.row]
        return cell
    }
}

internal class careworkerReviewDTO: UITableViewCell {
    @IBOutlet weak var oneLineText: UILabel!
}
