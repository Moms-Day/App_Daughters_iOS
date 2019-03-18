//
//  RankContentVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 01/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
import Alamofire

class RankContentVC: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankTableView: dynamicTableView!
    @IBOutlet weak var myRankView: UIView!
    @IBOutlet weak var myStarRatingView: SwiftyStarRatingView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myLocation: UILabel!
    
    
    var id:Bool! // hospital: true, careworker: false
    var myHospital: [Hospital]? = []
    var hospitalRanking: [Hospital]? = []
    var myCareworker: [Careworker]? = []
    var careworkerRanking: [Careworker]? = []
    var selectedCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if id {
            myLabel.text = "나의 병원"
            rankLabel.text = "병원 순위"
            rankTableView.height = CGFloat((110*(hospitalRanking?.count ?? 1)))
            if myHospital?.count != 0 {
                for i in (myHospital?.indices)! {
                    if myHospital![i].facilityCode == UserDefaults.standard.string(forKey: "facilityCode") {
                        myName.text = myHospital![i].name
                        myLocation.text = myHospital![i].address
                        myStarRatingView.value = CGFloat(myHospital![i].overall)
                    }
                }
            }
        } else {
            myLabel.text = "나의 요양보호사"
            rankLabel.text = "요양보호사 순위"
            rankTableView.height = CGFloat((110*(careworkerRanking?.count ?? 1)))
            if myCareworker?.count != 0 {
                for i in (myCareworker?.indices)! {
                    if myCareworker![i].careworkerId == UserDefaults.standard.string(forKey: "careId") {
                        myName.text = myCareworker![i].name
                        myLocation.text = myCareworker![i].workplace
                        myStarRatingView.value = CGFloat(myCareworker![i].overall)
                    }
                }
            }
        }
        
        self.myRankView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(goRankInform)))
        rankTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHospitalInform" {
            let hospitalInformVC = segue.destination as! HospitalInformVC
            hospitalInformVC.facilityCode = self.selectedCode
        } else if segue.identifier == "showCareworkerInform" {
            let careworkerInformVC = segue.destination as! CareworkerInformVC
            careworkerInformVC.careId = self.selectedCode
        }
    }
    
    func callApi() {
        if id {
            let header: HTTPHeaders = ["Authorization" : "JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
            Alamofire.request("http://52.78.5.142/daughter/ranking/facility", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject {(response: DataResponse<FacilityRankModel>) in
                let model = response.result.value
                for i in (model?.facilityRanking?.indices)! {
                    self.hospitalRanking?.append(Hospital(address: (model?.facilityRanking![i].address) ?? "", facilityCode: (model?.facilityRanking![i].facilityCode) ?? "", imagePath: (model?.facilityRanking![i].imagePath) ?? "", name: (model?.facilityRanking![i].name) ?? "", overall: (model?.facilityRanking![i].overall) ?? 0.0))
                }
                for i in (model?.myFacility?.indices)! {
                    self.myHospital?.append(Hospital(address: (model?.myFacility![i].address) ?? "", facilityCode: (model?.myFacility![i].facilityCode) ?? "", imagePath: (model?.myFacility![i].imagePath) ?? "", name: (model?.myFacility![i].name) ?? "", overall: (model?.myFacility![i].overall) ?? 0.0))
                }
                
//                self.reloadData()
            }
        } else {
            let header: HTTPHeaders = ["Authorization" : "JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
            Alamofire.request("http://52.78.5.142/daughter/ranking/care_worker", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject {(response: DataResponse<CareworkerRankModel>) in
                let model = response.result.value
                for i in (model?.careworkerRanking?.indices)! {
                    self.careworkerRanking?.append(Careworker(careworkerId: (model?.careworkerRanking![i].careworkerId) ?? "", imagePath: (model?.careworkerRanking![i].imagePath) ?? "", name: (model?.careworkerRanking![i].name) ?? "", overall: (model?.careworkerRanking![i].overall) ?? 0.0, workplace: (model?.careworkerRanking![i].workplace) ?? ""))
                }
                for i in (model?.myCareworker?.indices)! {
                    self.myCareworker?.append(Careworker(careworkerId: (model?.myCareworker![i].careworkerId) ?? "", imagePath: (model?.myCareworker![i].imagePath) ?? "", name: (model?.myCareworker![i].name) ?? "", overall: (model?.myCareworker![i].overall) ?? 0.0, workplace: (model?.myCareworker![i].workplace) ?? ""))
                }
            }
        }
    }
    
    func reloadData() {
        rankTableView.height = CGFloat((110*(hospitalRanking?.count ?? 1)))
        rankTableView.reloadData()
    }
    
    @objc func goRankInform(sender : UITapGestureRecognizer) {
        if id {
            self.performSegue(withIdentifier: "showHospitalInform", sender: nil)
            selectedCode = UserDefaults.standard.string(forKey: "facilityCode") ?? ""
        } else {
            self.performSegue(withIdentifier: "showCareworkerInform", sender: nil)
            selectedCode = UserDefaults.standard.string(forKey: "careId") ?? ""
        }
    }
}

extension RankContentVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if id {return hospitalRanking?.count ?? 0}
        else {return careworkerRanking?.count ?? 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell") as! rankDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if id {
            cell.rankNameLabel.text = hospitalRanking![indexPath.row].name
            cell.rankLocationLabel.text = hospitalRanking![indexPath.row].address
            cell.rankStarRatingView.value = CGFloat(hospitalRanking![indexPath.row].overall)
        } else {
            cell.rankNameLabel.text = careworkerRanking![indexPath.row].name
            cell.rankLocationLabel.text = careworkerRanking![indexPath.row].workplace
            cell.rankStarRatingView.value = CGFloat(careworkerRanking![indexPath.row].overall)
        }
        cell.rankStarRatingView.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if id {
            selectedCode = hospitalRanking![indexPath.row].facilityCode
            self.performSegue(withIdentifier: "showHospitalInform", sender: nil)
        } else {
            selectedCode = careworkerRanking![indexPath.row].careworkerId
            self.performSegue(withIdentifier: "showCareworkerInform", sender: nil)
        }
    }
}

internal class rankDTO: UITableViewCell {
    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var rankNameLabel: UILabel!
    @IBOutlet weak var rankLocationLabel: UILabel!
    @IBOutlet weak var rankStarRatingView: SwiftyStarRatingView!
    @IBOutlet weak var rankView: UIView!
}

internal class Hospital {
    var address: String
    var facilityCode: String
    var imagePath: String
    var name: String
    var overall: Float
    
    init(address: String, facilityCode: String, imagePath: String, name: String, overall: Float) {
        self.address = address
        self.facilityCode = facilityCode
        self.imagePath = imagePath
        self.name = name
        self.overall = overall
    }
}

internal class Careworker {
    var careworkerId: String
    var imagePath: String
    var name: String
    var overall: Float
    var workplace: String
    
    init(careworkerId: String, imagePath: String, name: String, overall: Float, workplace: String) {
        self.careworkerId = careworkerId
        self.imagePath = imagePath
        self.name = name
        self.overall = overall
        self.workplace = workplace
    }
}
