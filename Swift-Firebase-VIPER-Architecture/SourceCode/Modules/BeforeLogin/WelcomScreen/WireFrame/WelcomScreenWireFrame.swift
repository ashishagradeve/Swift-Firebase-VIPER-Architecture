//
//  WelcomScreenWireFrame.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

class WelcomScreenWireFrame: WelcomScreenWireFrameProtocol {
    
    func moveToMainScreenAfterLogin() {
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = ProfileScreenWireFrame.createProfileScreenModule()
        window??.makeKeyAndVisible()
    }
    
    class func createWelcomScreenModule() -> UIViewController {
        let navController = StoryBoard.mainStoryboard.instantiateViewController(withIdentifier: "WelcomeNavigationController")
        if let view = navController.childViewControllers.first as? WelcomScreenView {
            let presenter: WelcomScreenPresenterProtocol & WelcomScreenInteractorOutputProtocol = WelcomScreenPresenter()
            let interactor: WelcomScreenInteractorInputProtocol & WelcomScreenRemoteDataManagerOutputProtocol = WelcomScreenInteractor()
            let remoteDataManager: WelcomScreenRemoteDataManagerInputProtocol = WelcomScreenRemoteDataManager()
            let wireFrame: WelcomScreenWireFrameProtocol = WelcomScreenWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    func presentScreen(from view: WelcomScreenViewProtocol, forPost post: ProfileDetail?) {
        if let view = view as? WelcomScreenView {
            let mobileView = MobileVerificationWireFrame.createMobileVerificationModule()
            mobileView.profileDetail = post
            view.navigationController?.pushViewController(mobileView, animated: true)
            
        }
    }
    
}
