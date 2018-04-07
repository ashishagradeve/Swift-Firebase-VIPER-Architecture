//
//  MobileVerificationPresenter.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit

class MobileVerificationPresenter: MobileVerificationPresenterProtocol {
    
    
    
    weak var view: MobileVerificationViewProtocol?
    var interactor: MobileVerificationInteractorInputProtocol?
    var wireFrame: MobileVerificationWireFrameProtocol?
    
    func btnClickOnCancel() {
        interactor?.btnClickOnCancel()
        view?.endEditing()
    }
    
    func btnClickOnDone(with name:String?, phCode:String?, phoneNo:String?, img:UIImage?) {
        interactor?.btnClickOnDone(with: name, phCode: phCode, phoneNo: phoneNo, img: img)
        view?.endEditing()
        view?.showLoading()
    }
    
    func btnClickOnPhoto() {
        interactor?.btnClickOnPhoto(view:view!)
        view?.endEditing()
    }
    
    func btnClickOnCountryCode() {
        wireFrame?.addCountryViewView(from: view!)
        view?.endEditing()
    }
    
    func viewDidLoad(data: ProfileDetail?) {
        interactor?.viewDidLoad(data: data)
    }
    
    func clickOnResendMessage(phonNumber: String) {
        interactor?.clickOnResendMessage(phonNumber: phonNumber)
    }
    
    func send(verificationCode: String?, verificationID: String,ph:String) {
        view?.showLoading()
        interactor?.send(verificationCode: verificationCode, verificationID: verificationID, ph: ph)
    }
    
    func upload(with name: String, phCode: String, phoneNo: String, img: UIImage?) {
        interactor?.upload(with: name, phCode: phCode, phoneNo: phoneNo, img: img)
    }
}

//MARK:- MobileVerificationInteractorOutputProtocol
extension MobileVerificationPresenter: MobileVerificationInteractorOutputProtocol {
    func userSuccessfullySignup() {
        wireFrame?.userSuccessfullySignup()
    }
    
    
    func showAlertWithMessage(string: String) {
        view?.showAlertWithMessage(string: string)
        view?.hideLoading()
    }
    
    func hideLoader() {
        view?.hideLoading()
    }
    func popView() {
        view?.popView()
    }
    
    func setIntialFirstName(string: String) {
        view?.setIntialFirstName(string: string)
    }
    
    func setIntialProfileImage(url: URL) {
        view?.setIntialProfileImage(url: url)
    }
    
    func getVerificationID(verifyId: String) {
        view?.hideLoading()
        view?.getVerificationID(verifyId: verifyId)
    }
    
    func mobileNumberSuccessfullyRegister() {
        view?.mobileNumberSuccessfullyRegister()
    }

}


