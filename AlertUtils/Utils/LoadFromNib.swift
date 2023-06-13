//
//  LoadFromNib.swift
//  EndoPersonal
//
//  Created by 陳力維 on 2019/12/25.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

//使用cell只能將class掛在xib的對象上 因此無法用於storyboard 或 code 直接使用
class LoadFromNib: UIView,NibOwnerLoadable {
    
    @IBInspectable
    open var NibName: String = ""
    
    func `init`<T>(nib:T)->T{
        
        return loadNibContent(nibName:  String.init(describing:  type(of: nib))) as! T
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    override open func awakeFromNib(){
        super.awakeFromNib()
        if NibName.isEmpty{
            return
        }
        loadNibContent(nibName: NibName)
    }
}

protocol NibOwnerLoadable: AnyObject {
    static var nib: UINib { get }
}

// MARK: - Default implmentation
extension NibOwnerLoadable {
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: - Supporting methods
extension NibOwnerLoadable where Self: UIView {
    
    @discardableResult
    func loadNibContent(nibName:String? = nil)->UIView {
        
        let nib = UINib(nibName: nibName ?? String(describing: Self.self), bundle: Bundle.main)
        guard let views = nib.instantiate(withOwner: self, options: nil) as? [UIView],
            let contentView = views.first else {
                fatalError("Fail to load \(self) nib content")
        }

        //use xib size as default size if we generate view from code
        if self.frame == .zero {
            self.frame = contentView.frame
        }
        
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        return contentView
    }
}
