//
//  CommonMethods.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 16/03/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

import Foundation
import UIKit

func showAlertMessage(string:String? , viewController : UIViewController?){
    
    let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
    let dismiss = UIAlertAction(title: "Dismiss".localized(), style: .default , handler: nil)
    alert.addAction(dismiss)
    
    if let viewController = viewController {
        viewController.present(alert, animated: true, completion: nil)
    } else {
        DispatchQueue.main.async {
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        }
    }
}



