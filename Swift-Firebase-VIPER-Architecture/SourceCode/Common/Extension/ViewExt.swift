//
//  ViewExt.swift
//  Snappy
//
//  Created by Ashish Agrawal on 2/15/17.
//  Copyright © 2017 Snappy Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var makeItRound: Bool {
        get {
            return self.makeItRound
        }
        set {
            layer.cornerRadius = self.frame.size.height/2
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return self.borderColor
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
