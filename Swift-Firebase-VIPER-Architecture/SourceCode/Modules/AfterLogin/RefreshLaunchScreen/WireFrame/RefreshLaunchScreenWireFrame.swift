//
//  RefreshLaunchScreenWireFrame.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

class RefreshLaunchScreenWireFrame: RefreshLaunchScreenWireFrameProtocol {
    
    class func createRefreshLaunchScreenModule() -> RefreshLaunchScreenView {
        let view = StoryBoard.mainStoryboard.instantiateViewController(withIdentifier: "RefreshLaunchScreenView") as! RefreshLaunchScreenView
        let presenter: RefreshLaunchScreenPresenterProtocol & RefreshLaunchScreenInteractorOutputProtocol = RefreshLaunchScreenPresenter()
        let interactor: RefreshLaunchScreenInteractorInputProtocol & RefreshLaunchScreenRemoteDataManagerOutputProtocol = RefreshLaunchScreenInteractor()
        let remoteDataManager: RefreshLaunchScreenRemoteDataManagerInputProtocol = RefreshLaunchScreenRemoteDataManager()
        let wireFrame: RefreshLaunchScreenWireFrameProtocol = RefreshLaunchScreenWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
        
    }
   
    func userSuccessfullyLogin() {
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = ProfileScreenWireFrame.createProfileScreenModule()
        window??.makeKeyAndVisible()
    }
    
    func moveToLoginScreen() {
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = WelcomScreenWireFrame.createWelcomScreenModule()
        window??.makeKeyAndVisible()
    }
}
