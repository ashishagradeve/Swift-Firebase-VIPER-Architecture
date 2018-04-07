//
//  ProfileScreenPresenter.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit

class ProfileScreenPresenter: ProfileScreenPresenterProtocol {
    
    weak var view: ProfileScreenViewProtocol?
    var interactor: ProfileScreenInteractorInputProtocol?
    var wireFrame: ProfileScreenWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.viewDidLoad()
    }
    
    func btnClickOnSignOut() {
        interactor?.btnClickOnSignOut()
    }
    
}

extension ProfileScreenPresenter: ProfileScreenInteractorOutputProtocol {
    func setIntialFirstName(string: String) {
        view?.setIntialFirstName(string: string)
    }
    
    func setIntialProfileImage(url: URL) {
        view?.setIntialProfileImage(url: url)
    }
    
    func setIntialCountryCode(string: String) {
        view?.setIntialCountryCode(string: string)
    }
    
    func setIntialPhoneNumber(string: String) {
        view?.setIntialPhoneNumber(string: string)
    }
    
    func moveToLogin() {
        wireFrame?.moveToLogin()
    }
    
    func showError(error:String) {
        view?.hideLoading()
        view?.showError(error: error)
    }
    func hideLoader() {
        view?.hideLoading()
    }
    

}


