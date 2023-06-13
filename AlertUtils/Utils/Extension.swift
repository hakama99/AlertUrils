import UIKit

extension UIView {
        
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        
    }
    
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }}
    
    @IBInspectable var viewBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    //設定陰影
    func setViewShadow(shadowOffset: CGSize, shadowColor: CGColor, shadowOpacity: Float = 1.0,  shadowRadius: CGFloat? = nil, cornerRadius: CGFloat? = nil){
        if let cornerRadius = cornerRadius{
            layer.cornerRadius = cornerRadius
        }
        if let shadowRadius = shadowRadius{
            layer.shadowRadius = shadowRadius
        }
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor
    }
    //設定圓角
    func customCorners(corners: CACornerMask, radius: CGFloat, bounds: Bool? = nil){
        if bounds != nil{
            clipsToBounds = bounds!
        }
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    
    @objc var className:String{
        return String.init(describing:  type(of: self))
    }
    
    @objc static var className:String{
        return String.init(describing: self)
    }
    
    public func attachViewLayout(_ view:UIView)
    {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutAttachAll(to: self)
    }
    
    private func layoutAttachAll(to parentView:UIView)
    {
        let left = self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0)
        let right = self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0)
        let bottom = self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0)
        let top = self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0)
        NSLayoutConstraint.activate([
            left,
            right,
            bottom,
            top
        ])
    }
}
