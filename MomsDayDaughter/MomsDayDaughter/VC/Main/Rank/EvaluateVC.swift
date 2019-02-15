//
//  EvaluateVC.swift
//  MomsDayDaughter
//
//  Created by daeun on 11/02/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import UITextView_Placeholder


class EvaluateVC: UIViewController {

    @IBOutlet weak var oneLineTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneLineTextView.placeholder = "한 줄 평가"
        oneLineTextView.placeholderColor = UIColor.lightGray
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        navigationItem.titleView = titleLabel
        titleLabel.text = "평가"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(finishEvaluate))
    }
    @objc func finishEvaluate() {
        let alert = UIAlertController(title: "요양병원 평가가 완료되었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {(UIAlertAction) -> Void in _ = self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

extension EvaluateVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "evaluateCell") as! evaluateDTO
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

internal class evaluateDTO: UITableViewCell {
    
}
