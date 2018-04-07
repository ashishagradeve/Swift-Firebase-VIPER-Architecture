//
//  RefreshLaunchScreenPresenter.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit

class RefreshLaunchScreenPresenter: RefreshLaunchScreenPresenterProtocol {
    
    weak var view: RefreshLaunchScreenViewProtocol?
    var interactor: RefreshLaunchScreenInteractorInputProtocol?
    var wireFrame: RefreshLaunchScreenWireFrameProtocol?
    
    func refreshView() {
//        view?.showLoading()
        interactor?.refreshView()
    }
}

extension RefreshLaunchScreenPresenter: RefreshLaunchScreenInteractorOutputProtocol {
    
    func userSuccessfullyLogin() {
        view?.hideLoader()
        wireFrame?.userSuccessfullyLogin()
    }
    
    func moveToLoginScreen() {
        view?.hideLoader()
        wireFrame?.moveToLoginScreen()
    }
    
    func showError(error:String) {
        view?.hideLoader()
        view?.showError(error: SomethingWentWrongPleasetryAgain.localized()!)
        wireFrame?.moveToLoginScreen()
    }
    
}


