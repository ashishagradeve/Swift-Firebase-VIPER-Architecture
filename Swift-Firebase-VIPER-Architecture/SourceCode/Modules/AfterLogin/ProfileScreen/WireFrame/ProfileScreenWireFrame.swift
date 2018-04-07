//
//  ProfileScreenWireFrame.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

class ProfileScreenWireFrame: ProfileScreenWireFrameProtocol {
    
    class func createProfileScreenModule() -> UINavigationController {
        let navController = StoryBoard.afterLoginStoryboard.instantiateViewController(withIdentifier: "ProfileScreenNavigationController") as! UINavigationController
        let view = navController.childViewControllers.first as! ProfileScreenView
        let presenter: ProfileScreenPresenterProtocol & ProfileScreenInteractorOutputProtocol = ProfileScreenPresenter()
        let interactor: ProfileScreenInteractorInputProtocol & ProfileScreenRemoteDataManagerOutputProtocol = ProfileScreenInteractor()
        let remoteDataManager: ProfileScreenRemoteDataManagerInputProtocol = ProfileScreenRemoteDataManager()
        let wireFrame: ProfileScreenWireFrameProtocol = ProfileScreenWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    func moveToLogin() {
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = WelcomScreenWireFrame.createWelcomScreenModule()
        window??.makeKeyAndVisible()
    }
    
}
