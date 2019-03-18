//
//  SearchHospitalVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 05/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import Alamofire

class SearchHospitalVC: UIViewController {
    @IBOutlet weak var hospitalNameTextField: UITextField!
    @IBOutlet weak var searchHospitalTableView: UITableView!
    
    var hospitals: [Hospitals] = []
    var model: [SearchHospitalModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func searchButtonClick(_ sender: Any) {
        
        let header: HTTPHeaders = ["Authorization" : "JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
        let params = ["facilityName" : (hospitalNameTextField.text)!]
        Alamofire.request("http://52.78.5.142/daughter/connect/search", method: .get, parameters: params, encoding: URLEncoding.queryString, headers: header).responseArray {(response: DataResponse<[SearchHospitalModel]>) in
            
            if response.response?.statusCode == 200 {
                self.model = response.result.value
                
                if self.model == nil {
                    self.hospitals = []
                } else {
                    for i in (self.model?.indices)! {
                        self.hospitals.append(Hospitals(name: (self.model?[i].name)!, location: (self.model?[i].address)!))
                    }
                }
                self.searchHospitalTableView.reloadData()
            }
        }
        
    }
    class Hospitals {
        var name: String!
        var location: String!
        
        init(name: String, location: String) {
            self.name = name
            self.location = location
        }
    }
}

extension SearchHospitalVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchHospitalCell") as! searchHospitalDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.hospitalNameLabel.text = hospitals[indexPath.row].name
        cell.locationLabel.text = hospitals[indexPath.row].location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        let vc = self.navigationController?.viewControllers[(navigationController?.viewControllers.count ?? 2)-1] as! ConnectVC
        vc.hospitalName = hospitals[indexPath.row].name
        for i in (model?[indexPath.row].careworkers?.indices)! {
            vc.careworkerArray.append(ConnectVC.Careworker(careworkerId: model?[indexPath.row].careworkers?[i].id ?? "", careworkerName: model?[indexPath.row].careworkers?[i].name ?? ""))
        }
    }
}

internal class searchHospitalDTO: UITableViewCell {
    @IBOutlet weak var hospitalNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
}
