//
//  RankInformVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 07/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class HospitalInformVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HospitalInformVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! reviewDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

internal class reviewDTO: UITableViewCell {
    
}
