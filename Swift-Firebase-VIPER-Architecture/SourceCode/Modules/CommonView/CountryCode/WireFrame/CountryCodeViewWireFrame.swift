//
//  CountryCodeViewWireFrame.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 18/02/17.
//  Copyright © 2018 Ashish Agrawal. All rights reserved.
//

import UIKit

class CountryCodeViewWireFrame: CountryCodeViewWireFrameProtocol {
    
    static func createCountryCodeViewModule() -> CountryCodeViewView {
        
        let view = Bundle.main.loadNibNamed(NibName.countryCodeView, owner: nil, options: nil)?[0] as! CountryCodeViewView
        let presenter: CountryCodeViewPresenterProtocol = CountryCodeViewPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        view.frame = UIScreen.main.bounds
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addSubview(view)
        }
        return view
        
    }
    
}
