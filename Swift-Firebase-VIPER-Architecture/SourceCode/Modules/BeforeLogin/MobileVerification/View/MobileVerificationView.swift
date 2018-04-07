//
//  MobileVerificationView.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit
import PKHUD
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import CountryPicker
import Kingfisher

class MobileVerificationView: UIViewController {
    
    var presenter: MobileVerificationPresenterProtocol?
    var profileDetail:ProfileDetail?
    var selectedImage:UIImage? {
        didSet {
            imgProfilePhoto.image = selectedImage
        }
    }

    @IBOutlet weak var txtFldName: localizedTextField!
    @IBOutlet weak var txtFldPhoneNumber: localizedTextField!
    @IBOutlet weak var imgProfilePhoto: UIImageView!
    @IBOutlet weak var btnDone: LocalizedButton!
    @IBOutlet weak var lblCountryCode: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(data: profileDetail)
    }
    
    @IBAction func btnClickOnCancel(_ sender: Any) {
        presenter?.btnClickOnCancel()
    }

    @IBAction func btnClickOnDone(_ sender: Any) {
        presenter?.btnClickOnDone(with: txtFldName.text, phCode: lblCountryCode.text, phoneNo: txtFldPhoneNumber.text, img: selectedImage)
    }

    @IBAction func btnClickOnAddPhoto(_ sender: Any) {
        presenter?.btnClickOnPhoto()
    }

    @IBAction func btnClickOnCountryCode(_ sender: Any) {
        presenter?.btnClickOnCountryCode()
    }
}

//MARK:- UITextFieldDelegate
extension MobileVerificationView:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- UITextFieldDelegate
extension MobileVerificationView:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
//MARK:- CountryCodeViewDelegate
extension MobileVerificationView: CountryCodeViewDelegate {
    func selected(countryCode code: String) {
        profileDetail?.countryCode = code
        lblCountryCode.text = code
    }
}

//MARK:- MobileVerificationViewProtocol
extension MobileVerificationView: MobileVerificationViewProtocol {
    func getVerificationID(verifyId: String) {
       let alert =  UIAlertController.init(title: "OTP is send to your mobile number \(lblCountryCode.text! + txtFldPhoneNumber.text!)", message: "", preferredStyle: .alert)
        
        //Add text field
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "OTP"
        }
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: {[weak self] (handler) in
            let otp = alert.textFields?.first?.text
            self?.presenter?.send(verificationCode: otp, verificationID: verifyId, ph: (self?.lblCountryCode.text)! + (self?.txtFldPhoneNumber.text)!)
        }))
        alert.addAction(UIAlertAction.init(title: "Resend", style: .default, handler: {[weak self] (handler) in
            self?.presenter?.clickOnResendMessage(phonNumber: (self?.lblCountryCode.text)! + (self?.txtFldPhoneNumber.text)!)
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mobileNumberSuccessfullyRegister() {
        presenter?.upload(with: txtFldName.text!, phCode: lblCountryCode.text!, phoneNo: txtFldPhoneNumber.text!, img: selectedImage)
    }
    
    func showAlertWithMessage(string: String) {
        showToast(message: string)
    }
    
    func setIntialFirstName(string:String){
        txtFldName.text = string
    }

    func setIntialProfileImage(url:URL){
        imgProfilePhoto.kf.setImage(with: url)
    }
    
    func enableDoneButton(isEnabled:Bool) {
        btnDone.isEnabled = isEnabled
    }
    
    func showError(error:String) {
        HUD.flash(.label(error), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
