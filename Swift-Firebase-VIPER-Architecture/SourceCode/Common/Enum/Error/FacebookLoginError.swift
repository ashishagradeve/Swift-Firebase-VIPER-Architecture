//
//  FacebookLoginError.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 16/03/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

import Foundation

enum FacebookLoginError: Error {
    case cancelled
    case error(error:Error)
    case SomethingWentWrongPleasetryAgain
}
