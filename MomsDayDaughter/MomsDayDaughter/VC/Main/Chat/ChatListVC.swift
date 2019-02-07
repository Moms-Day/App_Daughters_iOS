//
//  ChatVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 24/01/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit

class ChatListVC: UIViewController {
    

    @IBOutlet weak var careworkerChatView: UIView!
    @IBOutlet weak var hospitalChatView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.careworkerChatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(goCareworkerChat)))
        self.hospitalChatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(goHospitalChat)))
    }
    
    @objc func goCareworkerChat(sender : UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "showCareworkerChat", sender: nil)
    }
    @objc func goHospitalChat(sender : UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "showHospitalChat", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chatVC = segue.destination as! ChatVC
        if segue.identifier == "showCareworkerChat" {
            chatVC.id = false
        } else {
            chatVC.id = true
        }
    }
}
