//
//  MobileVerificationRemoteDataManager.swift
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
import FirebaseStorage

class MobileVerificationRemoteDataManager:MobileVerificationRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: MobileVerificationRemoteDataManagerOutputProtocol?
    
    func checkPhoneNumberExist(phoneNumber: String) {
        let databaseRef = Database.database().reference()
        databaseRef.child("RegisterMobile").observeSingleEvent(of: DataEventType.value, with: {[weak self] (snapshot) in
            if snapshot.hasChild(phoneNumber){
                self?.remoteRequestHandler?.showAlertWithMessage(string: pleaseEnterDiffNo)
                //"true rooms exist")
            }else{
                self?.remoteRequestHandler?.phoneNumberNotRegister(phoneNumber: phoneNumber)
                //"false room doesn't exist")
            }
        })
    }
    
    func verify(phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {[weak self] (verificationID, error) in
            if let error = error {
                self?.remoteRequestHandler?.showAlertWithMessage(string: error.localizedDescription)
                return
            }
            if let verificationID = verificationID {
                self?.remoteRequestHandler?.getVerificationID(verifyId: verificationID)
            }
            
            // Sign in using the verificationID and the code sent to the user
            // ...
        }
    }
    
    func verify(verifyId: String,verifyCode: String,ph:String) {
        let credential = PhoneAuthProvider.provider().credential( withVerificationID: verifyId, verificationCode: verifyCode)
        Auth.auth().signIn(with: credential) {[weak self] (user, error) in
            if let error = error {
                self?.remoteRequestHandler?.showAlertWithMessage(string: error.localizedDescription)
                return
            }
            
            let ref = Database.database().reference()
            ref.child("RegisterMobile").child(ph).setValue(["phoneNumber":ph])
            self?.remoteRequestHandler?.mobileNumberSuccessfullyRegister()
            // User is signed in
            // ...
        }
    }
    
    func callingFirebaseFacebookLoginApi() {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) {[weak self]  (user, error) in
            if let eror = error {
                self?.remoteRequestHandler?.showAlertWithMessage(string: eror.localizedDescription)
                return
            }
            self?.remoteRequestHandler?.reLoginWithFacebookSuccessfullyRegister()
        }
    }
    
    func upload(with name: String, phCode: String, phoneNo: String, img: UIImage?) {
        let ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid {
            if let img = img ,let data = UIImagePNGRepresentation(img) {
                let storageRef = Storage.storage().reference()
                // Create a reference to the file you want to upload
                let riversRef = storageRef.child("\(uid)/profile.jpg")
                
//                let metadata = StorageMetadata()
//                metadata.contentType = "image/jpeg"

                // Upload the file to the path "images/rivers.jpg"
                let _ = riversRef.putData(data, metadata: nil) {[weak self] (metadata, error) in
                    guard let metadata = metadata else {
                        self?.remoteRequestHandler?.showAlertWithMessage(string: (error?.localizedDescription)!)
                        // Uh-oh, an error occurred!
                        return
                    }
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata.downloadURL()?.absoluteString
                    ref.child("users").child(uid).setValue(["name": name,"phCode": phCode,"phoneNo": phoneNo,"profileURL": downloadURL!])
                    self?.remoteRequestHandler?.userSuccessfullySignup()
                }
            } else {
                if let facebookID = FBSDKAccessToken.current().userID {
                    ref.child("users").child(uid).setValue(["name": name,"phCode": phCode,"phoneNo": phoneNo,"profileURL": "http://graph.facebook.com/\(facebookID)/picture?type=square"])
                    self.remoteRequestHandler?.userSuccessfullySignup()
                }
            }
        }
    }
    
}
