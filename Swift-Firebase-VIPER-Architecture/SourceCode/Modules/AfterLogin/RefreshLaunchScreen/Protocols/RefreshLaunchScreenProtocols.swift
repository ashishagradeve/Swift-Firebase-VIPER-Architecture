//
//  RefreshLaunchScreenProtocols.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

protocol RefreshLaunchScreenViewProtocol: class {
    var presenter: RefreshLaunchScreenPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showError(error:String)
    func hideLoader()
    func showLoading()
}

protocol RefreshLaunchScreenWireFrameProtocol: class {
    static func createRefreshLaunchScreenModule() -> RefreshLaunchScreenView
    // PRESENTER -> WIREFRAME
    
    func userSuccessfullyLogin()
    func moveToLoginScreen()
    
}

protocol RefreshLaunchScreenPresenterProtocol: class {
    var view: RefreshLaunchScreenViewProtocol? { get set }
    var interactor: RefreshLaunchScreenInteractorInputProtocol? { get set }
    var wireFrame: RefreshLaunchScreenWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func refreshView()
}

protocol RefreshLaunchScreenInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func showError(error:String)    
    func userSuccessfullyLogin()
    func moveToLoginScreen()

}

protocol RefreshLaunchScreenInteractorInputProtocol: class {
    var presenter: RefreshLaunchScreenInteractorOutputProtocol? { get set }
    var remoteDatamanager: RefreshLaunchScreenRemoteDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
   
    func refreshView()
}

protocol RefreshLaunchScreenRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RefreshLaunchScreenRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func refreshView()
    
}

protocol RefreshLaunchScreenRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func showError(error:String)    
    func userSuccessfullyLogin()
    func moveToLoginScreen()
}

