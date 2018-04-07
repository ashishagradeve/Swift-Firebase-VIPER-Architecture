//
//  CountryCodeViewView.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit
import CountryPicker

class CountryCodeViewView: UIView {
    
    var presenter: CountryCodeViewPresenterProtocol?
    var countryCode:String = "+91"
    var delegate:CountryCodeViewDelegate?

    
    static func createCountryCodeViewModule(addOnview:UIView) -> CountryCodeViewView {
        
        let view = Bundle.main.loadNibNamed(NibName.countryCodeView, owner: self, options: nil)?[0] as! CountryCodeViewView
        let presenter: CountryCodeViewPresenterProtocol = CountryCodeViewPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        view.frame = UIScreen.main.bounds
        addOnview.addSubview(view)
        return view
        
    }
    //MARK:- IBOutlet
    @IBOutlet weak var pkView: CountryPicker! {
        didSet{
            let locale = Locale.current
            let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
            //init Picker
            pkView.countryPickerDelegate = self
            pkView.showPhoneNumbers = true
            pkView.setCountry(code!)
        }
    }
    //MARK:- IBAction
    @IBAction func btnClickOnCancel(_ sender: Any) {
        presenter?.btnClickOnCancel()
    }
    
    
    @IBAction func btnClickOnDone(_ sender: Any) {
        presenter?.btnClickOnDone()
    }
    
}

extension CountryCodeViewView:CountryCodeViewViewProtocol {
    func removeView() {
        self.removeFromSuperview()
    }
    func setCountryCode(){
        delegate?.selected(countryCode: countryCode)
    }
}

//MARK:- CountryCode
extension CountryCodeViewView:CountryPickerDelegate {
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        self.countryCode = phoneCode
    }
}

