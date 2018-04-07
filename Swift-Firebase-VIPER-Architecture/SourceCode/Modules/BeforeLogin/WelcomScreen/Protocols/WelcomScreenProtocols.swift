//
//  WelcomScreenProtocols.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

protocol WelcomScreenViewProtocol: class {
    var presenter: WelcomScreenPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func onDataFromFacebookLogin(data:ProfileDetail)

    func showError(error:String)
    
    func showLoading()
    
    func hideLoading()
}

protocol WelcomScreenWireFrameProtocol: class {
    static func createWelcomScreenModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentScreen(from view: WelcomScreenViewProtocol, forPost post: ProfileDetail?)
    func moveToMainScreenAfterLogin()
}

protocol WelcomScreenPresenterProtocol: class {
    var view: WelcomScreenViewProtocol? { get set }
    var interactor: WelcomScreenInteractorInputProtocol? { get set }
    var wireFrame: WelcomScreenWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func callingFacebookLoginApi( from view:UIViewController)

}

protocol WelcomScreenInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func showError(error:String)
    func hideLoader()
    func onDataFromFacebookLogin(data:ProfileDetail)
    func userSuccessfullyLogin()
    func userSignUpThroughFacebook()
}

protocol WelcomScreenInteractorInputProtocol: class {
    var presenter: WelcomScreenInteractorOutputProtocol? { get set }
    var remoteDatamanager: WelcomScreenRemoteDataManagerInputProtocol? { get set }
    func callingFacebookLoginApi( from view:UIViewController)

    // PRESENTER -> INTERACTOR
}



protocol WelcomScreenRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: WelcomScreenRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func callingFacebookLoginApi( from view:UIViewController)
    func callingFirebaseFacebookLoginApi()
    
}

protocol WelcomScreenRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onDataFromFacebookLogin(data:ProfileDetail)
    func onErrorFromFacebookLogin(error:FacebookLoginError)
    func userSuccessfullyLogin()
    func userSignUpThroughFacebook()
    
}

