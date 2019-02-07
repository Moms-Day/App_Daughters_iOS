//
//  ChatVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 07/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    var id: Bool = true // hospital: true, careworker: false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        navigationItem.titleView = titleLabel
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        if id {
            titleLabel.text = "요양병원"
        } else {
            titleLabel.text = "요양보호사"
        }
    }
}
