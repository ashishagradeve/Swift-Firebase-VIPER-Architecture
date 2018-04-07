//
//  localizedTextField.swift
//  olxLikeApp
//
//  Created by jukebox0001 on 07/06/17.
//  Copyright © 2017 Ashish Agrawal. All rights reserved.
//

import UIKit

class localizedTextField: UITextField {

    
    private var updatePlaceHolder = false

    override var placeholder: String? {
        didSet {
            self.checkData()
        }
    }
    private func localizedPlaceHolder() {
        if let _ = self.placeholder  {
            if  let text = self.placeholder?.localized() {
                updatePlaceHolder = true
                print("placeholder from UITextField")
                self.placeholder = text
                updatePlaceHolder = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkData()
    }
    
    func checkData() {
        if updatePlaceHolder == false {
            self.localizedPlaceHolder()
        }
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    //    @IBInspectable var isLocalizedPlaceHolder:Bool? {
    //        set {
    //            self.localizedPlaceHolder()
    //        } get {
    //            return self.isLocalizedPlaceHolder
    //        }
    //    }
    //
    //    @IBInspectable var isLocalizedText:Bool? {
    //        set {
    //            self.localizedText()
    //        } get {
    //            return self.isLocalizedText
    //        }
    //    }
    
    //    override var text: String? {
    //        didSet {
    //            print("title from UITextField")
    //
    //            if updateText == false {
    //                self.localizedText()
    //            }
    //        }
    //    }
//    private var updateText = false

//    private func localizedText() {
//        if let _ = self.text  {
//            if let localized = isLocalizedText , localized == true ,  let text = self.text?.localized() {
//                updateText = true
//                self.text = text
//                updateText = false
//            }
//        }
//    }
    
}
