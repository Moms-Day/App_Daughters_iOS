//
//  ViewController.swift
//  MomsDayDaughter
//
//  Created by daeun on 25/11/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class LoginVC: UIViewController {
    
    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var pwLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func login(_ sender: UIButton) {
        
        if (idLabel.text?.isEmpty)! || (pwLabel.text?.isEmpty)! {
            let alert = UIAlertController(title: "오류", message: "모두 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Alamofire.request("http://52.78.5.142/daughter/auth", method: .post, parameters: ["id": idLabel.text!,"pw":pwLabel.text!],encoding: JSONEncoding.default, headers: nil).responseObject { (response:DataResponse<LoginModel>) in
                if response.response?.statusCode == 200 {
                    let loginModel = response.result.value
                    UserDefaults.standard.set(loginModel?.accessToken, forKey: "accessToken")
                    self.performSegue(withIdentifier: "goMain", sender: nil)
                } else {
                    let alert = UIAlertController(title: "오류", message: "아이디 또는 비밀번호가 맞지 않습니다.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

