//
//  EvaluateVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 11/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import UITextView_Placeholder
import DLRadioButton
import Alamofire
import SwiftyStarRatingView


class EvaluateVC: UIViewController {

    @IBOutlet weak var oneLineTextView: UITextView!
    @IBOutlet weak var evaluateListTableView: dynamicTableView!
    @IBOutlet weak var overallStarRatingView: SwiftyStarRatingView!
    
    var id: Bool! //hospital: true, careworker: false
    var evaluateList: [String]!
    var code: String = ""
    var scores: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneLineTextView.placeholder = "한 줄 평가"
        oneLineTextView.placeholderColor = UIColor.lightGray
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        navigationItem.titleView = titleLabel
        titleLabel.text = "평가"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        if id {
            evaluateList = ["시설", "식단", "일정", "비용", "서비스"]
        } else {
            evaluateList = ["성실", "친절도"]
        }
        evaluateListTableView.height = CGFloat(55 * evaluateList.count)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(finishEvaluate))
    }
    
    @objc func finishEvaluate() {
        scores = []
        
        for i in evaluateList.indices {
            let cell = evaluateListTableView.cellForRow(at: IndexPath(row: i, section: 0)) as! evaluateDTO
            if cell.selectedScore == nil {
                let alert = UIAlertController(title: "오류", message: "모두 평가해주세요.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            } else {
                scores.append(cell.selectedScore!)
            }
        }
        
        if id {
            let params = ["equipment":scores[0], "meal":scores[1], "schedule":scores[2], "cost":scores[3],"service":scores[4],"overall":Float(overallStarRatingView.value), "lineE":oneLineTextView.text ?? ""] as [String : Any]
            
            let header: HTTPHeaders = ["Authorization":"JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
            
            let url = "http://52.78.5.142/daughter/evaluate/facility/\(code)"
            
            Alamofire.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                print(response)
                
                if response.response?.statusCode == 201 {
                    let alert = UIAlertController(title: "요양병원 평가가 완료되었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.navigationController?.popViewController(animated: true)}))
                    self.present(alert, animated: true, completion: nil)

                } else {
                    let alert = UIAlertController(title: "오류", message: "\((response.response?.statusCode)!)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let params = ["diligence":scores[0], "kindness":scores[1], "overall":Float(overallStarRatingView.value), "lineE":oneLineTextView.text ?? ""] as [String : Any]
            
            let header: HTTPHeaders = ["Authorization":"JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
            
            let url = "http://52.78.5.142/daughter/evaluate/care_worker/\(code)"

            Alamofire.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                print(response)
                
                if response.response?.statusCode == 201 {
                    let alert = UIAlertController(title: "요양보호사 평가가 완료되었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.navigationController?.popViewController(animated: true)}))
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "오류", message: "\((response.response?.statusCode)!)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

extension EvaluateVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evaluateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "evaluateCell") as! evaluateDTO
        cell.evaluateListLabel.text = evaluateList![indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

internal class evaluateDTO: UITableViewCell {
    
    var selectedScore: Int?
    @IBOutlet weak var evaluateListLabel: UILabel!
    @IBOutlet weak var fiveButton: DLRadioButton!
    @IBOutlet weak var fourButton: DLRadioButton!
    @IBOutlet weak var threeButton: DLRadioButton!
    @IBOutlet weak var twoButton: DLRadioButton!
    @IBOutlet weak var oneButton: DLRadioButton!
    
    @IBAction func fiveButtonClick(_ sender: DLRadioButton) {
        selectedScore = 5
    }
    @IBAction func fourButtonClick(_ sender: DLRadioButton) {
        selectedScore = 4
    }
    @IBAction func threeButtonClick(_ sender: DLRadioButton) {
        selectedScore = 3
    }
    @IBAction func twoButtonClick(_ sender: DLRadioButton) {
        selectedScore = 2
    }
    @IBAction func oneButtonClick(_ sender: DLRadioButton) {
        selectedScore = 1
    }
}
