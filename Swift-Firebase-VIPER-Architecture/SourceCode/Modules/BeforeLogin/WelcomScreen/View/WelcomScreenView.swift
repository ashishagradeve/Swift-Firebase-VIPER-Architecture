//
//  WelcomScreenView.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit
import PKHUD

class WelcomScreenView: UIViewController {
    
    var presenter: WelcomScreenPresenterProtocol?
    var dicUserfacebook:ProfileDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnClickOnLoginViaFacebook(_ sender: Any) {
        presenter?.callingFacebookLoginApi(from: self)
    }
    
}

extension WelcomScreenView: WelcomScreenViewProtocol {
    func onDataFromFacebookLogin(data: ProfileDetail) {
        dicUserfacebook = data
    }
    
    func showError(error:String) {
        HUD.flash(.label(error), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
}
