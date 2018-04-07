//
//  RefreshLaunchScreenView.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit
import PKHUD
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import CountryPicker
import Kingfisher

class RefreshLaunchScreenView: UIViewController {
    
    var presenter: RefreshLaunchScreenPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.refreshView()
    }
    
}


extension RefreshLaunchScreenView: RefreshLaunchScreenViewProtocol {
    
    func showError(error:String) {
        HUD.flash(.label(error), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoader() {
        HUD.hide()
    }
}
