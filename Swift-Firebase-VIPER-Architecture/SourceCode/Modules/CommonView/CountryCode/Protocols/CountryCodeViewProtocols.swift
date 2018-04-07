//
//  CountryCodeViewProtocols.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

protocol CountryCodeViewViewProtocol: class {
    var presenter: CountryCodeViewPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func removeView() 
    func setCountryCode()
}

protocol CountryCodeViewPresenterProtocol: class {
    var view: CountryCodeViewViewProtocol? { get set }
    
    // VIEW -> PRESENTER
    func btnClickOnCancel()
    func btnClickOnDone()

}

protocol CountryCodeViewDelegate {
    func selected(countryCode code:String)
}

protocol CountryCodeViewWireFrameProtocol {
    static func createCountryCodeViewModule() -> CountryCodeViewView
}
