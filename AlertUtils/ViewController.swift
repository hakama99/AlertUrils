//
//  ViewController.swift
//  AlertUtils
//
//  Created by 陳力維 on 2023/6/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        normalPopview()
        //textfieldPopview()
    }

    func textfieldPopview(){
        let alert = TextfieldPopview.init()
        alert.titleLabel.text = "input password"
        alert.setConfirmCb {
            let password = alert.passwrldTextfield.text!
            print("input password \(password)")
            NormalAlertUtils.shared().dismiss()
        }
        alert.setCancelCb {
            NormalAlertUtils.shared().dismiss()
        }
        NormalAlertUtils.shared().show(alert: alert)
    }
    
    func normalPopview(){
        let alert = NormalTextAlert.init()
        alert.setMessage(text: "hello")
        alert.addButton(text: "ok", textColor: .blue) {[unowned self] in
            nextPopview()
        }
        alert.addButton(text: "cancel", textColor: .blue) {
            NormalAlertUtils.shared().dismiss()
        }
        NormalAlertUtils.shared().show(alert: alert)
    }
    
    func nextPopview(){
        let alert = NormalTextAlert.init()
        alert.setMessage(text: "next popview")
        alert.addButton(text: "ok", textColor: .blue) {
            NormalAlertUtils.shared().dismiss(alert: alert)
        }
        NormalAlertUtils.shared().show(alert: alert)
    }
}

