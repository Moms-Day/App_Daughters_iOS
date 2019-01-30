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
        
        viewControllers.append(twoDaysAgoViewController)
        viewControllers.append(yesterdayViewController)
        viewControllers.append(todayViewController)
        return viewControllers
    } ()


    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.dataSource = self
        pageViewController.delegate = self

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            pageViewController.dataSource = self
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
            
            
        }
    }
}

extension InquiryVC: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let curlIndex = viewControllers.index(of: viewController) else { return nil }
        let prePageIndex = curlIndex - 1
        if prePageIndex < 0 {
            return viewControllers.last
        } else {
            return viewControllers[prePageIndex]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let curlIndex = viewControllers.index(of: viewController) else { return nil }
        let prePageIndex = curlIndex + 1
        if prePageIndex >= viewControllers.count {
            return viewControllers.first
        } else {
            return viewControllers[prePageIndex]
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
