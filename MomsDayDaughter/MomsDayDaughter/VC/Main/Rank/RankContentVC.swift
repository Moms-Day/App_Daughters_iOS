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
    var id:Bool! // hospital이 true, careworker가 false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if id {
            myLabel.text = "나의 병원"
            rankLabel.text = "병원 순위"
        } else {
            myLabel.text = "나의 요양보호사"
            rankLabel.text = "요양보호사 순위"
        }
    }

}
