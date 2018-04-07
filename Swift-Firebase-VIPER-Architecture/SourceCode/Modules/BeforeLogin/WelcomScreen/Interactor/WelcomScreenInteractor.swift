//
//  WelcomScreenInteractor.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit

class WelcomScreenInteractor: WelcomScreenInteractorInputProtocol {
    weak var presenter: WelcomScreenInteractorOutputProtocol?
    var remoteDatamanager: WelcomScreenRemoteDataManagerInputProtocol?
    
    func callingFacebookLoginApi( from view:UIViewController){
        remoteDatamanager?.callingFacebookLoginApi(from: view)
    }
        
}

extension WelcomScreenInteractor: WelcomScreenRemoteDataManagerOutputProtocol {
    func userSuccessfullyLogin() {
        presenter?.userSuccessfullyLogin()
    }
    
    func userSignUpThroughFacebook() {
        presenter?.userSignUpThroughFacebook()
    }
    
    func onDataFromFacebookLogin(data:ProfileDetail) {
        presenter?.onDataFromFacebookLogin(data: data)
        remoteDatamanager?.callingFirebaseFacebookLoginApi()
    }
    func onErrorFromFacebookLogin(error:FacebookLoginError) {
        switch error {
        case .cancelled:
            break
        case .SomethingWentWrongPleasetryAgain:
            presenter?.showError(error: SomethingWentWrongPleasetryAgain.localized()!)
        case .error(error: _):
            break
        }
        presenter?.hideLoader()
    }
    
}
