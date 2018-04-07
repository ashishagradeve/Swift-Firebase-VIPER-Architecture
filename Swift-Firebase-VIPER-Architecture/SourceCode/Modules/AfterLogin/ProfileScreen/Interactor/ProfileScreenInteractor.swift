//
//  ProfileScreenInteractor.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit
import Firebase
import FBSDKLoginKit

class ProfileScreenInteractor: ProfileScreenInteractorInputProtocol {
    
    weak var presenter: ProfileScreenInteractorOutputProtocol?
    var remoteDatamanager: ProfileScreenRemoteDataManagerInputProtocol?
    
    func btnClickOnSignOut() {
        do {
            try Auth.auth().signOut()
        } catch  {
            
        }
        FBSDKLoginManager().logOut()
        presenter?.moveToLogin()
    }
    
    
    func viewDidLoad() {
        remoteDatamanager?.getAllDetail()
    }
}

extension ProfileScreenInteractor: ProfileScreenRemoteDataManagerOutputProtocol {
    func showError(error: String) {
        presenter?.showError(error: error)
    }
    
    func getAllDetail(data:[String:Any]?) {
        if let str = data?["name"] as? String  {
            presenter?.setIntialFirstName(string: str)
        }
        if let str = data?["profileURL"] as? String , let url = URL.init(string: str)  {
            presenter?.setIntialProfileImage(url:url)
        }
        
        if let str = data?["phoneNo"] as? String {
            presenter?.setIntialPhoneNumber(string: str)
        }
        if let str = data?["phCode"] as? String {
            presenter?.setIntialCountryCode(string: str)
        }
    }
    
}
