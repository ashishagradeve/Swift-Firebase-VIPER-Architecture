//
//  ProfileScreenView.swift
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

class ProfileScreenView: UIViewController {
    
    var presenter: ProfileScreenPresenterProtocol?
    
    @IBOutlet weak var txtFldName: localizedTextField!
    @IBOutlet weak var txtFldPhoneNumber: localizedTextField!
    @IBOutlet weak var imgProfilePhoto: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func btnClickOnSignOut(_ sender: Any) {
        presenter?.btnClickOnSignOut()
    }
}


extension ProfileScreenView: ProfileScreenViewProtocol {
    
    func setIntialFirstName(string:String){
        txtFldName.text = string
    }
    
    func setIntialCountryCode(string:String){
        lblCountryCode.text = string
    }
    
    func setIntialPhoneNumber(string:String){
        txtFldPhoneNumber.text = string
    }

    func setIntialProfileImage(url:URL){
        imgProfilePhoto.kf.setImage(with: url)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
    func showError(error:String) {
        HUD.flash(.label(error), delay: 2.0)
    }
    
}
