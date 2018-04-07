//
//  MobileVerificationProtocols.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

//MARK:- PRESENTER -> VIEW
protocol MobileVerificationViewProtocol: class {
    var presenter: MobileVerificationPresenterProtocol? { get set }
    
    func setIntialFirstName(string:String)
    func setIntialProfileImage(url:URL)
    func enableDoneButton(isEnabled:Bool)
    func showLoading()
    func hideLoading()
    func popView()
    func endEditing()
    func showAlertWithMessage(string:String)
    
    func getVerificationID(verifyId: String)
    func mobileNumberSuccessfullyRegister()
}

//MARK:- PRESENTER -> WIREFRAME
protocol MobileVerificationWireFrameProtocol: class {
    static func createMobileVerificationModule() -> MobileVerificationView
    func userSuccessfullySignup()
    func addCountryViewView(from view: MobileVerificationViewProtocol)
}

//MARK:-  VIEW -> PRESENTER
protocol MobileVerificationPresenterProtocol: class {
    var view: MobileVerificationViewProtocol? { get set }
    var interactor: MobileVerificationInteractorInputProtocol? { get set }
    var wireFrame: MobileVerificationWireFrameProtocol? { get set }
    
    //
    func btnClickOnCancel()
    func btnClickOnDone(with name:String?, phCode:String?, phoneNo:String?, img:UIImage?)
    func btnClickOnPhoto()
    func viewDidLoad(data:ProfileDetail?)
    func btnClickOnCountryCode()
    
    func clickOnResendMessage(phonNumber:String)
    func send(verificationCode:String?, verificationID:String,ph:String)
    func upload(with name:String, phCode:String, phoneNo:String, img:UIImage?)

}

//MARK:- INTERACTOR -> PRESENTER
protocol MobileVerificationInteractorOutputProtocol: class {
    //
    func hideLoader()
    func popView()
    func setIntialFirstName(string:String)
    func setIntialProfileImage(url:URL)
    func showAlertWithMessage(string:String)
    
    func getVerificationID(verifyId: String)
    func mobileNumberSuccessfullyRegister()
    func userSuccessfullySignup()
}

//MARK:- PRESENTER -> INTERACTOR
protocol MobileVerificationInteractorInputProtocol: class {
    var presenter: MobileVerificationInteractorOutputProtocol? { get set }
    var remoteDatamanager: MobileVerificationRemoteDataManagerInputProtocol? { get set }

    //
    func btnClickOnCancel()
    func btnClickOnDone(with name:String?, phCode:String?, phoneNo:String?, img:UIImage?)
    func upload(with name:String, phCode:String, phoneNo:String, img:UIImage?)
    func btnClickOnPhoto(view:MobileVerificationViewProtocol)
    func viewDidLoad(data:ProfileDetail?)
    
    func clickOnResendMessage(phonNumber:String)
    func send(verificationCode:String?, verificationID:String,ph:String)
    
}

//MARK:- INTERACTOR -> REMOTEDATAMANAGER
protocol MobileVerificationRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: MobileVerificationRemoteDataManagerOutputProtocol? { get set }
    
    func checkPhoneNumberExist(phoneNumber:String)
    func verify(phoneNumber: String)
    func upload(with name:String, phCode:String, phoneNo:String, img:UIImage?)
    func verify(verifyId: String,verifyCode: String,ph:String)
    func callingFirebaseFacebookLoginApi()
}

//MARK:-  REMOTEDATAMANAGER -> INTERACTOR
protocol MobileVerificationRemoteDataManagerOutputProtocol: class {
   
    func showAlertWithMessage(string:String)
    func phoneNumberNotRegister(phoneNumber:String)
    func getVerificationID(verifyId:String)
    func mobileNumberSuccessfullyRegister()
    func reLoginWithFacebookSuccessfullyRegister()
    func userSuccessfullySignup()
    
}

