//
//  CoinDetail.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 23/5/2565 BE.
//

import Foundation
import UIKit

class CoinDetail: UIView {
    /**
     @IBOutlet weak var cryptoIconImage: UIImageView!
     @IBOutlet weak var cryptoNameLabel: UILabel!
     @IBOutlet weak var cryptoSymbolLabel: UILabel!
     @IBOutlet weak var cryptoPriceLabel: UILabel!
     @IBOutlet weak var cryptoChangeLabel: UILabel!
     */
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var cryptoIconImage: UIImageView!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    @IBOutlet weak var cryptoSymbolLabel: UILabel!
    @IBOutlet weak var cryptoPriceLabel: UILabel!
    @IBOutlet weak var cryptoMarketCapLabel: UILabel!
    @IBOutlet weak var cryptoDescriptionLabel: UILabel!
    
    var touchOK: (()->Void)?
 
    init(uuid: String, touchOK: (()->Void)? = nil){
//        let window = UIApplication.shared.delegate!.window!!
        super.init(frame: .zero)
//        setup()
        
        self.touchOK = touchOK
        
//        let gestureOverlayView = UITapGestureRecognizer(target: self, action:  #selector (self.touchOverlayView (_:)))
//        self.overlayView.addGestureRecognizer(gestureOverlayView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        print("deinit PopUpView")
    }
    
//    func setup() {
//        // init inner view
//        let view = Bundle.main.loadNibNamed("CoinDetail", owner: self, options: nil)?[0] as! UIView
//        view.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(view)
//
//        // setup auto-layout
//        let views = ["contentView": view]
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [], metrics: nil, views: views))
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: views))
//
//        self.overlayView.alpha = 0
//        self.boxView.alpha = 0
//        self.boxView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
//
//    }
    
    func show() {
//        if PopUpView.showingPopUpViews.contains(where: {$0.titleLabel.text == self.titleLabel.text && $0.messageLabel.text == self.messageLabel.text}) {
//            // don't show if same popup is already beging shown
//            return
//        }
        let window = UIApplication.shared.delegate!.window!!
        self.backgroundColor = UIColor.clear
        window.addSubview(self)
        
        // add to showing list
//        PopUpView.showingPopUpViews.append(self)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.overlayView.alpha = 0.3
        }, completion: nil)
        
        UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseOut, animations: {
            self.boxView.alpha = 1
            self.boxView.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }) { (complete) in
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseOut, animations: {
                self.boxView.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            }, completion: nil)
        }
        
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.overlayView.alpha = 0.0
        }) { (complete) in
            self.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseOut, animations: {
            self.boxView.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }) { (complete) in
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseIn, animations: {
                self.boxView.alpha = 0
                self.boxView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
            }, completion: nil)
        }
        // remove from showing list
//        PopUpView.showingPopUpViews = PopUpView.showingPopUpViews.filter(){$0 != self}
    }
    
    @objc func touchOverlayView(_ sender:UITapGestureRecognizer){
        self.hide()
    }
    
    @IBAction func touchGoToWebsite(_ sender: Any) {
        print("som: Go To Website")
    }
    
    
}
