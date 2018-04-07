//
//  WelcomScreenPresenter.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit

class WelcomScreenPresenter: WelcomScreenPresenterProtocol {
    
    weak var view: WelcomScreenViewProtocol?
    var interactor: WelcomScreenInteractorInputProtocol?
    var wireFrame: WelcomScreenWireFrameProtocol?
    
    func callingFacebookLoginApi( from view:UIViewController) {
        interactor?.callingFacebookLoginApi(from: view)
    }
}

extension WelcomScreenPresenter: WelcomScreenInteractorOutputProtocol {
    func onDataFromFacebookLogin(data: ProfileDetail) {
        view?.onDataFromFacebookLogin(data: data)
        view?.showLoading()
    }
    
    func userSuccessfullyLogin() {
        wireFrame?.moveToMainScreenAfterLogin()
        view?.hideLoading()
    }
    
    func userSignUpThroughFacebook() {
        if let view = view as? WelcomScreenView {
            wireFrame?.presentScreen(from: view, forPost: view.dicUserfacebook)
        }
         view?.hideLoading()
    }

    func showError(error:String) {
        view?.showError(error: SomethingWentWrongPleasetryAgain.localized()!)
    }
    
    func hideLoader() {
        view?.hideLoading()
    }

}


