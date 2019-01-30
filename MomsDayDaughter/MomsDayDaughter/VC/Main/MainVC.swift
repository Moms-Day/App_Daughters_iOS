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
    }
    
    override func viewWillAppear(_ animated: Bool) {
                navigationController?.isNavigationBarHidden = false
    }
    
}
