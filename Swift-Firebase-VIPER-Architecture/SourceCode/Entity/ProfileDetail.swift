//
//  ProfileDetail.swift
//  SwIft-Firebase-VIPER-Architecture
//
//  Created by Ashish Agrawal on 03/04/18.
//  Copyright © 2018 Ashish. All rights reserved.
//

import UIKit

struct ProfileDetail {

    var facebookID:String
    var name:String?
    var countryCode:String?
    var phNo:String?
    var photoImageUrl:URL?
    
    
    init (dataFromFacebook:[String:Any]) {
        if let str = dataFromFacebook["name"] as? String {
            name = str
        }
        
        if let str = dataFromFacebook["id"] as? String, str.count > 0  {
            facebookID = str
            if let url = URL.init(string: "http://graph.facebook.com/\(str)/picture?type=square")  {
                photoImageUrl = url
            }
        } else {
            facebookID = ""
        }
    }
    
}
