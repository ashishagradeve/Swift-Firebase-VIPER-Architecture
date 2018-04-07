//
//  RefreshLaunchScreenInteractor.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit
import Firebase
import FBSDKLoginKit

class RefreshLaunchScreenInteractor: RefreshLaunchScreenInteractorInputProtocol {
   
    weak var presenter: RefreshLaunchScreenInteractorOutputProtocol?
    var remoteDatamanager: RefreshLaunchScreenRemoteDataManagerInputProtocol?
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch  {
            
        }
        FBSDKLoginManager().logOut()
        presenter?.moveToLoginScreen()
    }
    
    func refreshView() {
        remoteDatamanager?.refreshView()
    }
}

extension RefreshLaunchScreenInteractor: RefreshLaunchScreenRemoteDataManagerOutputProtocol {
    func showError(error: String) {
        signOut()
        presenter?.showError(error: error)
    }
    
    func userSuccessfullyLogin() {
        presenter?.userSuccessfullyLogin()
    }
    
    func moveToLoginScreen() {
        signOut()
    }
}
