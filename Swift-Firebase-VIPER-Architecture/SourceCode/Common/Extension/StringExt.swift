//
//  StringExt.swift
//  Snappy
//
//  Created by Ashish Agrawal on 2/15/17.
//  Copyright © 2017 Snappy Ltd. All rights reserved.
//

import Foundation

let bundle = Bundle(path: Bundle.main.path(forResource: "en", ofType: "lproj")!)

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
//    let bundle = Bundle(path: Bundle.main.path(forResource: AppUserDefaults.getLanguage(), ofType: "lproj")!)
    
    func localized() ->String? {
        return  NSLocalizedString(self.trimmingCharacters(in: .whitespacesAndNewlines), tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func getFloat () -> Float? {
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: self)
        return number?.floatValue
    }
}
