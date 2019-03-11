//
//  InquiryVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 24/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

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
    
    func callApi() {
        let header: HTTPHeaders = ["Authorization" : "JWT \(UserDefaults.standard.string(forKey: "accessToken")!)"]
        
        let parentId = UserDefaults.standard.string(forKey: "parentId")!
        
        Alamofire.request("http://52.78.5.142/daughter/form/\(parentId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject {
            (response:DataResponse<InquiryModel>) in
            
            let twoDaysAgoVC: InquiryContentVC = self.viewControllers[0] as! InquiryContentVC
            let yesterdayVC: InquiryContentVC = self.viewControllers[1] as! InquiryContentVC
            let todayVC: InquiryContentVC = self.viewControllers[2] as! InquiryContentVC
            
            let inquiryModel = response.result.value
            
            twoDaysAgoVC.setInquiry(date: (inquiryModel?.twoDaysAgo?.date) ?? "", breakfastMeal: (inquiryModel?.twoDaysAgo?.meal?.breakfast) ?? [""], lunchMeal: (inquiryModel?.twoDaysAgo?.meal?.lunch) ?? [""], dinnerMeal: (inquiryModel?.twoDaysAgo?.meal?.dinner) ?? [""], snack: inquiryModel?.twoDaysAgo?.meal?.snack ?? "", additionalDescription: inquiryModel?.twoDaysAgo?.additional?.description ?? "", photoPath: inquiryModel?.twoDaysAgo?.photo?.photoPath ?? "", photoComent: inquiryModel?.twoDaysAgo?.photo?.comment ?? "")
            for i in (inquiryModel?.twoDaysAgo?.schedule?.indices)! {
                twoDaysAgoVC.addSchedule(time: (inquiryModel?.twoDaysAgo?.schedule![i].time)!, work: (inquiryModel?.twoDaysAgo?.schedule![i].work)!)
            }
            
            twoDaysAgoVC.conditionBool = [self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].activityReduction),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].lowTemparature),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].highFever),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].bloodPressureincrease),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].bloodPressureReduction),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].lackOfSleep),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].loseAppetite),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].bingeEating),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].diarrhea),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].constipation),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].vomiting),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].urinationInconvenient),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].humanPowerReduction),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].povertyOfBlood),self.conditionCheck(condition: inquiryModel?.twoDaysAgo?.condition?[0].cough)]
            
            yesterdayVC.setInquiry(date: (inquiryModel?.yesterday?.date) ?? "", breakfastMeal: (inquiryModel?.yesterday?.meal?.breakfast)!, lunchMeal: (inquiryModel?.yesterday?.meal?.lunch) ?? [""], dinnerMeal: (inquiryModel?.yesterday?.meal?.dinner) ?? [""], snack: inquiryModel?.yesterday?.meal?.snack ?? "", additionalDescription: inquiryModel?.yesterday?.additional?.description ?? "", photoPath: inquiryModel?.yesterday?.photo?.photoPath ?? "", photoComent: inquiryModel?.yesterday?.photo?.comment ?? "")
            
            for i in (inquiryModel?.yesterday?.schedule?.indices)! {
                yesterdayVC.addSchedule(time: (inquiryModel?.yesterday?.schedule![i].time)!, work: (inquiryModel?.yesterday?.schedule![i].work)!)
            }
            
            yesterdayVC.conditionBool = [self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].activityReduction),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].lowTemparature),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].highFever),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].bloodPressureincrease),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].bloodPressureReduction),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].lackOfSleep),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].loseAppetite),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].bingeEating),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].diarrhea),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].constipation),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].vomiting),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].urinationInconvenient),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].humanPowerReduction),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].povertyOfBlood),self.conditionCheck(condition: inquiryModel?.yesterday?.condition?[0].cough)]
            
            todayVC.setInquiry(date: (inquiryModel?.today?.date) ?? "", breakfastMeal: (inquiryModel?.today?.meal?.breakfast) ?? [""], lunchMeal: (inquiryModel?.today?.meal?.lunch) ?? [""], dinnerMeal: (inquiryModel?.today?.meal?.dinner) ?? [""], snack: inquiryModel?.today?.meal?.snack ?? "", additionalDescription: inquiryModel?.today?.additional?.description ?? "", photoPath: inquiryModel?.today?.photo?.photoPath ?? "", photoComent: inquiryModel?.today?.photo?.comment ?? "")
            
            for i in (inquiryModel?.today?.schedule?.indices)! {
                todayVC.addSchedule(time: (inquiryModel?.today?.schedule![i].time)!, work: (inquiryModel?.today?.schedule![i].work)!)
            }
            
            todayVC.conditionBool = [self.conditionCheck(condition: inquiryModel?.today?.condition?[0].activityReduction),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].lowTemparature),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].highFever),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].bloodPressureincrease),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].bloodPressureReduction),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].lackOfSleep),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].loseAppetite),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].bingeEating),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].diarrhea),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].constipation),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].vomiting),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].urinationInconvenient),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].humanPowerReduction),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].povertyOfBlood),self.conditionCheck(condition: inquiryModel?.today?.condition?[0].cough)]
            
        }
    }
    
    func conditionCheck(condition: Bool?) -> Bool {
        if condition == nil {
            return false
        } else {
            return true
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
