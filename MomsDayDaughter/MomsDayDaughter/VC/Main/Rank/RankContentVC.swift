//
//  RankContentVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 01/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import MGStarRatingView

class RankContentVC: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankTableView: dynamicTableView!
    @IBOutlet weak var myStarRatingView: StarRatingView!
    @IBOutlet weak var myRankView: UIView!
    
    var id:Bool! // hospital: true, careworker: false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if id {
            myLabel.text = "나의 병원"
            rankLabel.text = "병원 순위"
        } else {
            myLabel.text = "나의 요양보호사"
            rankLabel.text = "요양보호사 순위"
        }
        
        rankTableView.height = (110*7)
        self.myRankView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(goMyRankInform)))
        myStarRatingView.justDisplay()
    }
    
    @objc func goMyRankInform(sender : UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "showMyInform", sender: nil)
    }
}

extension RankContentVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell") as! rankDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.rankStarRatingView.justDisplay()
        return cell
    }
}

internal class rankDTO: UITableViewCell {
    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var rankNameLabel: UILabel!
    @IBOutlet weak var rankLocationLabel: UILabel!
    @IBOutlet weak var rankStarRatingView: StarRatingView!
}
