//
//  NormalAlertUtils.swift
//  smartLEDZ
//
//  Created by 陳力維 on 2019/10/16.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit

@objc class NormalAlertUtils : NSObject{
    
    private let alertWindow: UIWindow
    private let alertController:UIViewController
    
    private static let instance = NormalAlertUtils()
    
    public static func shared() -> NormalAlertUtils {
        return instance
    }
    
    public override init() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene{
            alertWindow = UIWindow.init(windowScene: scene)
        }else{
            alertWindow = UIWindow.init()
        }
        alertWindow.backgroundColor = .clear
        alertWindow.windowLevel = .alert
        alertController =  UIViewController.init()
        alertWindow.rootViewController = alertController
        alertWindow.isHidden = true
        super.init()
    }
    
    func show(alert:UIView? = nil){
        if let alert = alert {
            alert.isHidden = false
            alertController.view.attachViewLayout(alert)
        }else{
            alertController.view.subviews.forEach {
                $0.isHidden = false
            }
        }
        alertWindow.isHidden = false
    }

    func dismiss(alert: UIView? = nil) {
        if let alert = alert {
            alertController.view.subviews.filter { $0 == alert }.forEach {
                $0.removeFromSuperview()
            }
        } else {
            alertController.view.subviews.forEach {
                $0.removeFromSuperview()
            }
            alertWindow.isHidden = true
        }
    }
    
    func hide(alert:UIView? = nil){
        if let alert = alert {
            alertController.view.subviews.filter { $0 == alert }.forEach {
                $0.isHidden = true
            }
        } else {
            alertController.view.subviews.forEach {
                $0.isHidden = true
            }
            alertWindow.isHidden = true
        }
    }
}
