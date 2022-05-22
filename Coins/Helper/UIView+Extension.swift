//
//  UIView+Extension.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 16/5/2565 BE.
//

import Foundation

extension UIView {
    // @objc func round - simpleSelectionCollectionCell override round, addBorder swift 4 override ไม่ได้
    // https://stackoverflow.com/questions/46564557/declarations-from-extensions-cannot-be-overridden-yet-in-swift-4
    
    /**
     For View that doesn't need ALL corner to be rounded
     */
    @discardableResult
    @objc func round(_ corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    /**
     For View that doesn't need ALL corner to be rounded
     */
    @objc func addBorder(_ mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) -> CAShapeLayer{
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        self.layer.addSublayer(borderLayer)
        return borderLayer
    }
    
    func imageViewFromSnapshot() -> UIImageView {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImageView(image:resultingImage)
    }
    
    func selectRoundView(border:inout CAShapeLayer?,borderWidth:CGFloat){
        (self as? UIButton)?.isSelected = true
        self.backgroundColor = Utility.MAIN_GREEN_COLOR
        border?.removeFromSuperlayer()
        border = self.addBorder(self.layer.mask as! CAShapeLayer, borderColor: Utility.MAIN_GREEN_COLOR, borderWidth: borderWidth)
        
    }
    
    func deSelectRoundView(border:inout CAShapeLayer?,borderWidth:CGFloat){
        (self as? UIButton)?.isSelected = false
        self.backgroundColor = UIColor.clear
        border?.removeFromSuperlayer()
        border = self.addBorder(self.layer.mask as! CAShapeLayer, borderColor: Utility.MAIN_GREEN_COLOR, borderWidth: borderWidth)
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = duration
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        if let delegate = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        
        self.layer.add(rotateAnimation, forKey: nil)
    }
}








