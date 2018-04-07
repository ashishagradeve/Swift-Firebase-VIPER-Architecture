//
//  WelcomScreenRemoteDataManager.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseDatabase

class WelcomScreenRemoteDataManager:WelcomScreenRemoteDataManagerInputProtocol {
  
    
    
    var remoteRequestHandler: WelcomScreenRemoteDataManagerOutputProtocol?
    
    func callingFacebookLoginApi( from view:UIViewController) {
        let login = FBSDKLoginManager()
        login.logOut()
        login.logIn(withReadPermissions: ["public_profile","email"], from: view) {[weak self] (result, error) in
            if let error = error {
                print("Process error")
                self?.remoteRequestHandler?.onErrorFromFacebookLogin(error: FacebookLoginError.error(error: error))
            }
            else if let cancel = result?.isCancelled , cancel == true {
                print("Cancelled")
                self?.remoteRequestHandler?.onErrorFromFacebookLogin(error: FacebookLoginError.cancelled)
            }
            else {
                let graph = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name,email"])
                _ = graph?.start{(connection, result, error) in
                    if let error = error  {
                        self?.remoteRequestHandler?.onErrorFromFacebookLogin(error: FacebookLoginError.error(error: error))
                    } else if let userdata = result as? Dictionary < String , AnyObject > {
                        self?.remoteRequestHandler?.onDataFromFacebookLogin(data: ProfileDetail.init(dataFromFacebook: userdata))
                    } else {
                        self?.remoteRequestHandler?.onErrorFromFacebookLogin(error: FacebookLoginError.SomethingWentWrongPleasetryAgain)
                    }
                }
            }
        }
    }
    func callingFirebaseFacebookLoginApi() {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential) {[weak self]  (user, error) in
            if let eror = error {
                self?.remoteRequestHandler?.onErrorFromFacebookLogin(error: FacebookLoginError.error(error: eror))
                return
            }
            
            if let id = Auth.auth().currentUser?.uid {
                let ref = Database.database().reference(withPath: "users")
                ref.child(id).observeSingleEvent(of: .value, with: {[weak self](snapshot) in
                    if snapshot.exists() {
                        //User is signing IN
                        self?.remoteRequestHandler?.userSuccessfullyLogin()
                    } else {
                        self?.remoteRequestHandler?.userSignUpThroughFacebook()
                        //User is signing UP
                    }
                })
            }
            
        }
    }
    
}
