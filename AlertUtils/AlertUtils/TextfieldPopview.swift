//
//  NormalTextAlert.swift
//  smartLEDZ
//
//  Created by 陳力維 on 2023/3/28.
//  Copyright © 2023 BNC. All rights reserved.
//

import UIKit

class TextfieldPopview:BasicAlert,NibOwnerLoadable{

    private var confirmAction: (() -> Void)?
    private var cancelAction: (() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwrldTextfield: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func setupViews() {
        super.setupViews()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        self.attachViewLayout(blurEffectView)
        
        loadNibContent()
        passwrldTextfield.addTarget(self, action: #selector(editChanged(textfield:)), for: .editingChanged)
        passwrldTextfield.addTarget(self, action: #selector(dismissKeyBoard), for: .editingDidEndOnExit)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView=false
        self.addGestureRecognizer(tap)
        setConfirmEnable()
    }
    
    @IBAction func onConfirmClick(_ sender: Any) {
        confirmAction?()
    }
    
    @IBAction func onCancelClick(_ sender: Any) {
        cancelAction?()
    }
    
    func setConfirmCb(action:@escaping (() -> Void)){
        confirmAction = action
    }
    
    func setCancelCb(action:@escaping (() -> Void)){
        cancelAction = action
    }
    
    @objc func editChanged(textfield:UITextField){
        setConfirmEnable()
    }
    
    @objc func dismissKeyBoard() {
        endEditing(true)
    }
    
    func setConfirmEnable(){
        let enable = passwrldTextfield.text!.count >= 8
        confirmBtn.isEnabled = enable
        confirmBtn.alpha = enable ? 1 : 0.7
    }
}
