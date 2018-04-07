
//
//  LocalizedLabel.swift
//  olxLikeApp
//
//  Created by jukebox0001 on 07/06/17.
//  Copyright © 2017 Ashish Agrawal. All rights reserved.
//

import UIKit

class LocalizedLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
        
    private var updateTextSpace: CGFloat?
//    @IBInspectable var textSpace: CGFloat? {
//        get {
//            return self.textSpace
//        }
//        set {
//            self.updateTextSpace = newValue
//            if let space = newValue {
//                if let _ = self.text {
//                    self.attributedText =  NSMutableAttributedString(string: self.text?.localized() ?? self.text!, attributes: [NSFontAttributeName:UIFont(name: self.font.fontName, size: self.font.pointSize)!, NSForegroundColorAttributeName:UIColor.white, NSKernAttributeName:space])
//                } else {
//                    self.text = "";
//                }
//            }
//        }
//    }
    
    override var text: String? {
        didSet {
            self.checkData()
        }
    }
    
    private var updateText = false

    private func localizedText() {
        if let _ = self.text  {
            if let text = self.text?.localized() {
                updateText = true
                print("title from UILabel \(String(describing: self.text)) 325435  \(text)")
                self.text = text
                updateText = false
            }
        }
    }
    
    
    override func awakeFromNib() {
         super.awakeFromNib()
        self.checkData()
    }
    
    func checkData () {
        if updateText == false && (self.updateTextSpace == 0 || self.updateTextSpace == nil) {
            self.localizedText()
        } else {
//            if let space = self.updateTextSpace {
//                self.attributedText =  NSMutableAttributedString(string: self.text?.localized() ?? "", attributes: [NSFontAttributeName:UIFont(name: self.font.fontName, size: self.font.pointSize)!, NSForegroundColorAttributeName:self.textColor, NSKernAttributeName:space])
//            } else {
//                //                    self.localizedText()
//            }
        }
    }
}
