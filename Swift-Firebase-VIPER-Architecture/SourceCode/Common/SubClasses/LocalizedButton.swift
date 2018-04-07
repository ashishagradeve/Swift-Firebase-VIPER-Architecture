//
//  LocalizedButton.swift
//  olxLikeApp
//
//  Created by jukebox0001 on 07/06/17.
//  Copyright © 2017 Ashish Agrawal. All rights reserved.
//

import UIKit

class LocalizedButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

//    @IBInspectable var isLocalized:Bool? {
//        set {
//            localizedText()
//        } get {
//            return self.isLocalized
//        }
//    }
    
    @IBInspectable var bgNormal:UIColor? {
        set {
            if let bgNormal = newValue {
                setButtonBackGroundColor(backgroundColor: bgNormal, forState: .normal)
            }
        } get {
            return self.bgNormal
        }
    }
    @IBInspectable var bgHighLight:UIColor? {
        set {
            if let bgHighLight = newValue {
                setButtonBackGroundColor(backgroundColor: bgHighLight, forState: .highlighted)
            }
        } get {
            return self.bgHighLight
        }
    }
    @IBInspectable var bgSelected:UIColor? {
        set {
            if let bgSelected = newValue {
                setButtonBackGroundColor(backgroundColor: bgSelected, forState: .selected)
            }
        } get {
            return self.bgSelected
        }
    }
    
    @IBInspectable var title:String? {
        didSet {
            if updateText == false {
                self.localizedText(text: title)
            }
        }
    }
    
    private var updateText = false
//    override func setTitle(_ title: String?, for state: UIControlState) {
//        if updateText == false {
//            self.localizedText(text: title)
//        }
//    }
    
    private func localizedText(text:String?) {
        if let text = text?.localized() {
            updateText = true
            print("title from button")
            self.setTitle(text, for: .normal)
            updateText = false
        }        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.localizedText(text: self.titleLabel?.text)
    }
}
