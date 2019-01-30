//
//  ViewController.swift
//  MomsDayDaughter
//
//  Created by daeun on 25/11/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var pwLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: UIButton) {
        if pwLabel.text == "1234" {
            performSegue(withIdentifier: "login", sender: nil)
        } else {
            let alert = UIAlertController(title: "비밀번호 오류", message: "비밀번호가 맞지 않습니다.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}

