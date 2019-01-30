//
//  MainVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 03/12/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import Foundation
import UIKit

class MainVC: UITabBarController {
    
    private var pageViewController: UIPageViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        navigationItem.titleView = titleLabel
        titleLabel.text = "메인"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
                navigationController?.isNavigationBarHidden = false
    }
    
}
