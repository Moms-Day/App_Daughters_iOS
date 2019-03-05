//
//  MyPageVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 05/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {
    
    var parentArray: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentArray = ["example1", "example2"]
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
    
}
