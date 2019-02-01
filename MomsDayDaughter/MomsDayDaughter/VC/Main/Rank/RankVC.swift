//
//  RankVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 24/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class RankVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var pageViewController: UIPageViewController!
    private lazy var viewControllers:[UIViewController] = {
        var viewControllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Rank", bundle: nil)
        let rankHospitalVC = storyboard.instantiateViewController(withIdentifier: "RankContent") as! RankContentVC
        let rankCareworkerVC = storyboard.instantiateViewController(withIdentifier: "RankContent") as! RankContentVC
        
        rankHospitalVC.id = true
        rankCareworkerVC.id = false
        
        viewControllers.append(rankHospitalVC)
        viewControllers.append(rankCareworkerVC)
        return viewControllers
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            pageViewController.dataSource = nil
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        }
    }
    
    @IBAction func adapterChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        default:
            pageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: false, completion: nil)
        }
    }
    
}

extension RankVC: UIPageViewControllerDelegate {
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
