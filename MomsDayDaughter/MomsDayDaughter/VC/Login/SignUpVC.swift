//
//  SignUpVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 15/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nextButton: TopBorderButton!
    private var index = 0
    private var pageViewController: UIPageViewController!
    private lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let firstIntroViewController = storyboard.instantiateViewController(withIdentifier: "signUpFirst") as! SignUpContentVC
        let secondIntroViewController = storyboard.instantiateViewController(withIdentifier: "signUpSecond") as! SignUpContentVC
        viewControllers.append(firstIntroViewController)
        viewControllers.append(secondIntroViewController)
        return viewControllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        navigationItem.titleView = titleLabel
        titleLabel.text = "회원가입"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(finishSignUp))
        
        navigationController?.isNavigationBarHidden = false
        }
    
    @objc func finishSignUp() {
        let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.navigationController?.popToRootViewController(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UIPageViewController {
            pageViewController = vc
            pageViewController.dataSource = nil
            pageViewController.delegate = self
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    @IBAction func clickNextButton(_ sender: TopBorderButton) {
        
        switch index {
        case 0:
            nextButton.setTitle("이전", for: UIControl.State.normal)
            pageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: true, completion: nil)
            index = 1
        default:
            nextButton.setTitle("다음", for: UIControl.State.normal)
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
            index = 0
        }
    }
}

extension SignUpVC: UIPageViewControllerDelegate {
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


class SignUpContentVC: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
