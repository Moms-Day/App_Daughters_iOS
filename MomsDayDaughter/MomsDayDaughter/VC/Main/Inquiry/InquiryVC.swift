//
//  InquiryVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 24/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class InquiryVC: UIViewController {
    
    private var pageViewController: UIPageViewController!
    private lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Inquiry", bundle: nil)
        let twoDaysAgoViewController = storyboard.instantiateViewController(withIdentifier: "InquiryContent") as! InquiryContentVC
        let yesterdayViewController = storyboard.instantiateViewController(withIdentifier: "InquiryContent") as! InquiryContentVC
        let todayViewController = storyboard.instantiateViewController(withIdentifier: "InquiryContent") as! InquiryContentVC
        
        twoDaysAgoViewController.id = "twoDaysAgo"
        yesterdayViewController.id = "yesterday"
        todayViewController.id = "today"
        
        viewControllers.append(twoDaysAgoViewController)
        viewControllers.append(yesterdayViewController)
        viewControllers.append(todayViewController)
        return viewControllers
    } ()


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllers[2]], direction: .forward, animated: false, completion: nil)
        }
    }
}

extension InquiryVC: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let curlIndex = viewControllers.index(of: viewController) else {return nil}
        switch curlIndex {
        case 1:
            return viewControllers[0]
        case 2:
            return viewControllers[1]
        default:
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let curlIndex = viewControllers.index(of: viewController) else {return nil}
        switch curlIndex {
        case 0:
            return viewControllers[1]
        case 1:
            return viewControllers[2]
        default:
            return nil
        }
    }
}

extension InquiryVC: UIPageViewControllerDelegate {
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
