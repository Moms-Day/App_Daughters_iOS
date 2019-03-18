//
//  MyPageVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 05/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import Alamofire

class MyPageVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var parentPickerView: UIPickerView!
    
    var parentArray: [String] = []
    var selectedRow = 0
    var model: MyPageModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeMyPage))
        
        let header: HTTPHeaders = ["Authorization" : "JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
        Alamofire.request("http://52.78.5.142/daughter/my_page/account_info", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject {(response: DataResponse<MyPageModel>) in
            self.model = response.result.value
            
            if response.response?.statusCode == 200 {
                self.nameLabel.text = "\((self.model?.name)!)(\((self.model?.age)!))"
                
                if self.model?.patients?.count != 0 {
                    for i in (self.model?.patients?.indices)! {
                        self.parentArray.append(self.model?.patients![i].name ?? "")
                    }
                }
                self.parentPickerView.reloadAllComponents()
            }
        }
    }
    
    @objc func completeMyPage() {
        navigationController?.popViewController(animated: true)
        let vc = navigationController?.viewControllers[1] as! MainVC
        vc.parentName = model?.patients?[selectedRow].name        
    }
}

extension MyPageVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return parentArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return parentArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
}
