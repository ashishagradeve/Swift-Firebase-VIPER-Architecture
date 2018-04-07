//
//  ProfileScreenRemoteDataManager.swift
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

class ProfileScreenRemoteDataManager:ProfileScreenRemoteDataManagerInputProtocol {
    func getAllDetail() {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            // Get user value
            self?.remoteRequestHandler?.getAllDetail(data: snapshot.value as? [String : Any])
            // ...
        }) {[weak self] (error) in
            self?.remoteRequestHandler?.showError(error: error.localizedDescription)
        }
    }
    
    
    var remoteRequestHandler: ProfileScreenRemoteDataManagerOutputProtocol?
    
    
    
}
