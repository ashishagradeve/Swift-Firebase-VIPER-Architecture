//
//  RefreshLaunchScreenRemoteDataManager.swift
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

class RefreshLaunchScreenRemoteDataManager:RefreshLaunchScreenRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: RefreshLaunchScreenRemoteDataManagerOutputProtocol?
    
    func refreshView() {
        if let id = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference(withPath: "users")
            ref.child(id).observeSingleEvent(of: .value, with: {[weak self](snapshot) in
                if snapshot.exists() {
                    //User is signing IN
                    self?.remoteRequestHandler?.userSuccessfullyLogin()
                } else {
                    self?.remoteRequestHandler?.moveToLoginScreen()
                    //User is signing UP
                }
            })
        } else {
            self.remoteRequestHandler?.moveToLoginScreen()
        }
    }
    
}
