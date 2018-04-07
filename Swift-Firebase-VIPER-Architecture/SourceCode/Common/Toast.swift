//
//  Toast.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 15/03/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

import UIKit

//MARK:- Toast

func showToast(message:String?)
{
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let label = UILabel(frame: CGRect.zero)
    label.textAlignment = NSTextAlignment.center
    label.text = message
    label.font = UIFont.systemFont(ofSize: 13)
    label.adjustsFontSizeToFitWidth = true
    
    label.backgroundColor =  UIColor.lightGray //UIColor.whiteColor()
    label.textColor = UIColor.white //TEXT COLOR
    
    label.sizeToFit()
    label.numberOfLines = 4
    label.layer.shadowColor = UIColor.gray.cgColor
    label.layer.shadowOffset = CGSize(width:4,height: 3)
    label.layer.shadowOpacity = 0.3
    label.frame = CGRect(x:320,y: 64,width: appDelegate.window!.frame.size.width, height:44)
    label.alpha = 1
    
    appDelegate.window!.addSubview(label)
    
    var basketTopFrame: CGRect = label.frame;
    basketTopFrame.origin.x = 0;
    
    UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
        label.frame = basketTopFrame
    },  completion: {
        (value: Bool) in
        UIView.animate(withDuration: 2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            label.alpha = 0
        },  completion: {
            (value: Bool) in
            label.removeFromSuperview()
        })
    })
}


