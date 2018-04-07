//
//  CountryCodeViewPresenter.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//
import UIKit

class CountryCodeViewPresenter: CountryCodeViewPresenterProtocol {
    
    weak var view: CountryCodeViewViewProtocol?
    
    func btnClickOnCancel() {
        view?.removeView()
    }
    
    func btnClickOnDone() {
        view?.removeView()
        view?.setCountryCode()
    }
}


