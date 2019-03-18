//
//  ConnectVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 05/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import DLRadioButton
import Alamofire

class ConnectVC: UIViewController {

    @IBOutlet weak var careworkerPickerView: UIPickerView!
    @IBOutlet weak var searchHospitalTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var parentNameTextField: UITextField!
    @IBOutlet weak var parentAgeTextField: UITextField!
    @IBOutlet weak var maleButton: DLRadioButton!
    @IBOutlet weak var femaleButton: DLRadioButton!
    
    var careworkerArray: [Careworker]! = []
    var hospitalName: String?
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchHospitalTextField.addTarget(self, action: #selector(goSearchHospital), for: UIControl.Event.touchDown)
        
        if hospitalName != nil {
            searchHospitalTextField.text = hospitalName!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if hospitalName != nil {
            searchHospitalTextField.text = hospitalName!
        }
        careworkerPickerView.reloadAllComponents()
    }
    
    @objc func goSearchHospital() {
        self.performSegue(withIdentifier: "goSearchHospital", sender: nil)
    }
    
    class Careworker {
        var careworkerId: String!
        var careworkerName: String!
        
        init(careworkerId: String, careworkerName: String) {
            self.careworkerId = careworkerId
            self.careworkerName = careworkerName
        }
    }
    @IBAction func connectClick(_ sender: Any) {
        
        if (nameTextField.text?.isEmpty)! || (parentNameTextField.text?.isEmpty)! || (parentAgeTextField.text?.isEmpty)! || (searchHospitalTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "오류", message: "모두 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let header: HTTPHeaders = ["Authorization" : "JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
            var patientGender: Bool = false
            if maleButton.isSelected {
                patientGender = true
            }
            
            let params = ["careId":(careworkerArray[selectedRow].careworkerId)!, "requesterId": UserDefaults.standard.string(forKey: "id")!, "requesterName":(nameTextField.text)!, "patientName":(parentNameTextField.text)!, "patientAge": Int((parentAgeTextField.text)!)!, "patientGender": patientGender] as [String : Any]
            
            print(params)
            
            Alamofire.request("http://52.78.5.142/daughter/connect/request", method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                
                if response.response?.statusCode == 201 {
                    let alert = UIAlertController(title: "연결요청이 완료되었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.navigationController?.popViewController(animated: true)}))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "오류", message: "\(response.response?.statusCode)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }

        }
    }
}

extension ConnectVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return careworkerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return careworkerArray[row].careworkerName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
}
