//
//  RankContentVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 01/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class RankContentVC: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankTableView: dynamicTableView!
    var id:Bool! // hospital: true, careworker: false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankTableView.height = (110*3)
        
        if id {
            myLabel.text = "나의 병원"
            rankLabel.text = "병원 순위"
        } else {
            myLabel.text = "나의 요양보호사"
            rankLabel.text = "요양보호사 순위"
        }
    }
}

extension RankContentVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell") as! rankDTO
        
        return cell
    }
}

internal class rankDTO: UITableViewCell {
    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var rankNameLabel: UILabel!
    @IBOutlet weak var rankLocationLabel: UILabel!
}
