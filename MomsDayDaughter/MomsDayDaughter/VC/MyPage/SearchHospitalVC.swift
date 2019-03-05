//
//  SearchHospitalVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 05/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class SearchHospitalVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SearchHospitalVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchHospitalCell") as! searchHospitalDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

internal class searchHospitalDTO: UITableViewCell {
    
}
