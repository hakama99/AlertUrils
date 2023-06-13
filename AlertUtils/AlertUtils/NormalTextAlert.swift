//
//  NormalTextAlert.swift
//  smartLEDZ
//
//  Created by 陳力維 on 2023/3/28.
//  Copyright © 2023 BNC. All rights reserved.
//

import UIKit

class NormalTextAlert:BasicAlert,NibOwnerLoadable{

    var alertAction: [(() -> Void)?] = []
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var stackview: UIStackView!
    private var buttonList: [UIButton] = []
    
    override func setupViews() {
        super.setupViews()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        self.attachViewLayout(blurEffectView)
        
        loadNibContent()
    }
    
    func addButton(text:String,textColor:UIColor,backgroundColor:UIColor = UIColor.clear,action:@escaping (() -> Void)){
        alertAction.append(action)
        let btn = UIButton.init()
        btn.tag = buttonList.count
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.viewCornerRadius = 6
        btn.addTarget(self, action: #selector(onButtonClick(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 50),
        ])
        stackview.addArrangedSubview(btn)
        buttonList.append(btn)
    }
    
    func setMessage(text:String){
        messageLabel.text = text
    }
    
    func setButtonDirection(axis:NSLayoutConstraint.Axis){
        stackview.axis = axis
    }
    
    @objc func onButtonClick(_ sender: UIButton){
        if alertAction.count>sender.tag{
            alertAction[sender.tag]?()
        }
    }
}
