//
//  MainVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 03/12/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper

class MainVC: UITabBarController {
    
    private var pageViewController: UIPageViewController!
    var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
    var parentName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        navigationItem.titleView = titleLabel
        titleLabel.text = "메인"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More", style: .plain, target: self, action: #selector(goMyPage))
    }
    
    @objc func goMyPage() {
        self.performSegue(withIdentifier: "goMyPage", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        callApi()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goRank" {
            let vc = segue.destination as! RankVC
            vc.callApi()
        }
    }
    
    func callApi() {
        
        let header: HTTPHeaders = ["Authorization" : "JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
        
        Alamofire.request("http://52.78.5.142/daughter/main", method: .get, parameters: nil,encoding: JSONEncoding.default, headers: header).responseArray {
            (response:DataResponse<[MainModel]>) in
            
            if response.response?.statusCode == 200 {
                if response.result.value?.isEmpty ?? true {
                    let alert = UIAlertController(title: "해당기능을 사용하기 위해선 요양보호사와의 연결이 필요합니다.", message: "요양보호사와 연결하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "연결하기", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.performSegue(withIdentifier: "goConnect", sender: nil)}))
                    alert.addAction(UIAlertAction(title: "랭킹보기", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.performSegue(withIdentifier: "goRank", sender: nil)}))
                    self.present(alert, animated: true, completion: nil)
                } else {

                    var mainModel: MainModel = response.result.value![0]
                    
                    if self.parentName != nil {
                        self.titleLabel.text = self.parentName!
                    } else {
                        self.titleLabel.text = mainModel.name
                    }
                    
                    for i in (response.result.value?.indices)! {
                            if response.result.value![i].name == self.parentName {
                                mainModel = response.result.value![i]
                            }
                        }
                    UserDefaults.standard.set(mainModel.id, forKey: "parentId")
                    UserDefaults.standard.set(mainModel.careId, forKey: "careId")
                    UserDefaults.standard.set(mainModel.facilityCode, forKey: "facilityCode")
                    let firstVC = self.viewControllers![0] as! InquiryVC
                    firstVC.callApi()
                    let thirdVC = self.viewControllers![2] as! RankVC
                    thirdVC.callApi()
                }
            } else {
                let alert = UIAlertController(title: "오류", message: "\(response.response?.statusCode)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
