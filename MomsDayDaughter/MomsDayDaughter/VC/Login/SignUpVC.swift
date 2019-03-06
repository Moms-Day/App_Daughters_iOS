//
//  SignUpVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 15/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import Alamofire

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nextButton: TopBorderButton!
    private var index = 0
    private var pageViewController: UIPageViewController!
    private lazy var viewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let firstIntroViewController = storyboard.instantiateViewController(withIdentifier: "signUpFirst") as! SignUpFirstContentVC
        let secondIntroViewController = storyboard.instantiateViewController(withIdentifier: "signUpSecond") as! SignUpSecondContentVC
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
        let firstVC = viewControllers[0] as! SignUpFirstContentVC
        let secondVC = viewControllers[1] as! SignUpSecondContentVC
        
        if nilCheck() {
            let params = ["id":firstVC.idTextField.text!,
                          "pw":firstVC.pwTextField.text!,
                          "phoneNumber":secondVC.telTextField.text!,
                          "certifyCode":secondVC.certifyCodeTextField.text!,
                          "name":secondVC.nameTextField.text!,
                          "age":Int(secondVC.ageTextField.text!)!] as [String : AnyObject]
            
            print(params)
            
            Alamofire.request("http://52.78.5.142/daughter/signup", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response { response in
                
                if response.response?.statusCode == 201 {
                    
                    let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.navigationController?.popToRootViewController(animated: true)}))
                    self.present(alert, animated: true, completion: nil)
                    
                } else if response.response?.statusCode == 409{
                    
                    let alert = UIAlertController(title: "오류", message: "id중복", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "오류", message: String(describing: response.response?.statusCode), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
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
    
    func nilCheck() -> Bool {
        let firstVC = viewControllers[0] as! SignUpFirstContentVC
        let secondVC = viewControllers[1] as! SignUpSecondContentVC
        
        if (firstVC.idTextField.text?.isEmpty)! || (firstVC.pwTextField.text?.isEmpty)! || (firstVC.pwCheckTextField.text?.isEmpty)! || (secondVC.telTextField.text?.isEmpty)! || (secondVC.certifyCodeTextField.text?.isEmpty)! || (secondVC.nameTextField.text?.isEmpty)! || (secondVC.ageTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "오류", message: "모두 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        } else {
            if firstVC.pwTextField.text! != firstVC.pwCheckTextField.text! {
                let alert = UIAlertController(title: "오류", message: "비밀번호를 잘못 입력하였습니다.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else {
                return true
            }
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


internal class SignUpFirstContentVC: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwCheckTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func asdf() {
        
    }
}

internal class SignUpSecondContentVC: UIViewController {
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var certifyCodeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
