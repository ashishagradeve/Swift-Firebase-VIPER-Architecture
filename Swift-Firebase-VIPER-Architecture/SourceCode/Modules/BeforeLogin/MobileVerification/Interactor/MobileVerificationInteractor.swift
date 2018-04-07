//
//  MobileVerificationInteractor.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit
import Firebase
import FBSDKLoginKit

class MobileVerificationInteractor: MobileVerificationInteractorInputProtocol {
    
    weak var presenter: MobileVerificationInteractorOutputProtocol?
    var remoteDatamanager: MobileVerificationRemoteDataManagerInputProtocol?
    
    func viewDidLoad(data: ProfileDetail?) {
        if let str = data?.name {
            presenter?.setIntialFirstName(string: str)
        }
        if let url = data?.photoImageUrl  {
            presenter?.setIntialProfileImage(url:url)
        }
    }
    
    func btnClickOnPhoto(view:MobileVerificationViewProtocol) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = view as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = false
            (view as? UIViewController)?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func btnClickOnCancel() {
        do {
            try Auth.auth().signOut()
        } catch  {
            
        }
        FBSDKLoginManager().logOut()
        presenter?.popView() 
    }
    
    func btnClickOnDone(with name:String?, phCode:String?, phoneNo:String?, img:UIImage?)  {
        guard let name = name?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) , name.count > 0 else {
            presenter?.showAlertWithMessage(string: pleaseEnterName)
            return
        }
        guard let phoneNo = phoneNo?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) , phoneNo.count > 0 else {
            presenter?.showAlertWithMessage(string: pleaseEnterPh)
            return
        }
        
        if let phCode = phCode?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) , phCode.count > 0 {
            remoteDatamanager?.checkPhoneNumberExist(phoneNumber: phCode + phoneNo)
        }
    }
    
    func clickOnResendMessage(phonNumber: String) {
        remoteDatamanager?.verify(phoneNumber: phonNumber)
    }
    
    func send(verificationCode: String?, verificationID: String,ph:String) {
        if let verificationCode = verificationCode?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) , verificationCode.count > 0 {
            remoteDatamanager?.verify(verifyId: verificationID, verifyCode: verificationCode,ph:ph)
        } else {
            presenter?.getVerificationID(verifyId: verificationID)
        }
    }
    
    func upload(with name: String, phCode: String, phoneNo: String, img: UIImage?) {
        remoteDatamanager?.upload(with: name, phCode: phCode, phoneNo: phoneNo, img: img)
    }
    
}

//MARK:- MobileVerificationRemoteDataManagerOutputProtocol
extension MobileVerificationInteractor: MobileVerificationRemoteDataManagerOutputProtocol {
    func userSuccessfullySignup() {
        presenter?.userSuccessfullySignup()
    }
    
    func showAlertWithMessage(string: String) {
        presenter?.showAlertWithMessage(string: string)
    }
    
    func phoneNumberNotRegister(phoneNumber: String) {
        presenter?.hideLoader()
        remoteDatamanager?.verify(phoneNumber: phoneNumber)
    }
    
    func getVerificationID(verifyId: String) {
        presenter?.getVerificationID(verifyId: verifyId)
    }
    
    func mobileNumberSuccessfullyRegister() {
        remoteDatamanager?.callingFirebaseFacebookLoginApi()
    }
    
    func reLoginWithFacebookSuccessfullyRegister() {
        presenter?.mobileNumberSuccessfullyRegister()
    }

    
}
