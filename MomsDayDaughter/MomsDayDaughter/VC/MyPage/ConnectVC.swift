//
//  ConnectVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 05/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class ConnectVC: UIViewController {

    @IBOutlet weak var careworkerPickerView: UIPickerView!
    @IBOutlet weak var searchHospitalTextField: UITextField!
    
    var careworkerArray: [String]! = ["example1","example2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchHospitalTextField.addTarget(self, action: #selector(goSearchHospital), for: UIControl.Event.touchDown)
    }
    
    @objc func goSearchHospital() {
        self.performSegue(withIdentifier: "goSearchHospital", sender: nil)
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
        return careworkerArray[row]
    }
}
