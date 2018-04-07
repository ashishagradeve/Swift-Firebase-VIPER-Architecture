//
//  ProfileScreenProtocols.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

protocol ProfileScreenViewProtocol: class {
    var presenter: ProfileScreenPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    
    func setIntialFirstName(string:String)
    func setIntialCountryCode(string:String)
    func setIntialPhoneNumber(string:String)
    func setIntialProfileImage(url:URL)
    func showLoading()
    func hideLoading()
    func showError(error:String) 
}

protocol ProfileScreenWireFrameProtocol: class {
    static func createProfileScreenModule() -> UINavigationController
    // PRESENTER -> WIREFRAME
    func moveToLogin()
}

protocol ProfileScreenPresenterProtocol: class {
    var view: ProfileScreenViewProtocol? { get set }
    var interactor: ProfileScreenInteractorInputProtocol? { get set }
    var wireFrame: ProfileScreenWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func btnClickOnSignOut()
    func viewDidLoad()
}

protocol ProfileScreenInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func showError(error:String)
    func hideLoader()
    func setIntialFirstName(string:String)
    func setIntialCountryCode(string:String)
    func setIntialPhoneNumber(string:String)
    func setIntialProfileImage(url:URL)
    func moveToLogin()

}

protocol ProfileScreenInteractorInputProtocol: class {
    var presenter: ProfileScreenInteractorOutputProtocol? { get set }
    var remoteDatamanager: ProfileScreenRemoteDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func btnClickOnSignOut()
    func viewDidLoad()
}

protocol ProfileScreenRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProfileScreenRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    
    func getAllDetail()
    
}

protocol ProfileScreenRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
   
    func showError(error:String)
    func getAllDetail(data:[String:Any]?)
}

