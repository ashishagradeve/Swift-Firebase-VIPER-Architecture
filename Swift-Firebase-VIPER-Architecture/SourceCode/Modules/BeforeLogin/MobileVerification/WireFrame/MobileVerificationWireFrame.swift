//
//  MobileVerificationWireFrame.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

class MobileVerificationWireFrame: MobileVerificationWireFrameProtocol {
    
    class func createMobileVerificationModule() -> MobileVerificationView {
        let view = StoryBoard.mainStoryboard.instantiateViewController(withIdentifier: "MobileVerificationView") as! MobileVerificationView
        let presenter: MobileVerificationPresenterProtocol & MobileVerificationInteractorOutputProtocol = MobileVerificationPresenter()
        let interactor: MobileVerificationInteractorInputProtocol & MobileVerificationRemoteDataManagerOutputProtocol = MobileVerificationInteractor()
        let remoteDataManager: MobileVerificationRemoteDataManagerInputProtocol = MobileVerificationRemoteDataManager()
        let wireFrame: MobileVerificationWireFrameProtocol = MobileVerificationWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
        
    }
    

    func userSuccessfullySignup() {
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = ProfileScreenWireFrame.createProfileScreenModule()
        window??.makeKeyAndVisible()
    }
    
    func addCountryViewView(from view: MobileVerificationViewProtocol) {
        let countryCode = CountryCodeViewWireFrame.createCountryCodeViewModule()
        countryCode.delegate = view as? CountryCodeViewDelegate
    }
    
}
