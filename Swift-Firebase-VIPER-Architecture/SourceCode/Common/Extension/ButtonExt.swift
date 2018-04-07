//
//  ButtonExt.swift
//  Snappy
//
//  Created by Ashish Agrawal on 2/16/17.
//  Copyright © 2017 Snappy Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var numberOfLinesOfText: Int {
        get {
            return self.numberOfLinesOfText
        }
        set {
            self.titleLabel?.numberOfLines = newValue
        }
    }
    
    func setButtonBackGroundColor(backgroundColorForNormal: UIColor , backgroundColorForHighlighted: UIColor ){
        
        self.setButtonBackGroundColor(backgroundColor: backgroundColorForNormal, forState:  .normal)
        self.setButtonBackGroundColor(backgroundColor: backgroundColorForHighlighted, forState:  .highlighted)
        self.setButtonBackGroundColor(backgroundColor: backgroundColorForHighlighted, forState:  .selected)
    }
    
    
    func setButtonBackGroundColor(backgroundColor: UIColor , forState:UIControlState )  {
        self.setBackgroundImage(createColorImage(backgroundColor: backgroundColor , height:20) , for: forState )
    }
}

func createColorImage(backgroundColor: UIColor , height:CGFloat) -> UIImage {
    let colorView = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 5, height: height))
    colorView.backgroundColor = backgroundColor;
    UIGraphicsBeginImageContext(colorView.bounds.size);
    colorView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImage!
}
