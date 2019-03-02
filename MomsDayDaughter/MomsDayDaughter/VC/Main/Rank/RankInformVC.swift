//
//  RankInformVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 07/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class RankInformVC: UIViewController {

    @IBOutlet weak var hospitalScoreView: UIView!
    @IBOutlet weak var careworkerScoreView: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var scoreViewContainer: UIView!
    
    var id: Bool! //hospital: true, careowrker: false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if id {
            hospitalScoreView.isHidden = false
            careworkerScoreView.isHidden = true
        } else {
            hospitalScoreView.isHidden = true
            careworkerScoreView.isHidden = false
        }
    }
}

extension RankInformVC: UITableViewDataSource, UITableViewDelegate {
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
