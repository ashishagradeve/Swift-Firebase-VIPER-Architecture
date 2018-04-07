//
//  NetworkConnection.swift
//  PingTank
//
//  Created by Ashish Agrawal on 10/25/16.
//  Copyright © 2016 Ashish Agrawal. All rights reserved.
//

import Foundation
import SystemConfiguration
import Reachability
//import Alamofire

var reachability: Reachability!
let BaseUrl = "https://api.tbaznis.com/v1/"
//MARK:- Reacibility

func reachibility(){
    
    reachability = Reachability.init()
    do {
        try reachability?.startNotifier()
    } catch {
        print("Unable to start notifier")
    }
}

let reachibilityConnection = NSNotification.Name(rawValue: "reachibilityConnection")

func isInternetAvailableReachibilty() -> Bool {
    if reachability.connection != .none {
        if reachability.connection == .wifi {
            NotificationCenter.default.post(name: reachibilityConnection, object: nil, userInfo: ["connect":"Reachable via WiFi"])
            return true
        } else if reachability.connection == .cellular  {
            NotificationCenter.default.post(name: reachibilityConnection, object: nil, userInfo: ["connect":"Reachable via Cellular"])
            return true
        } else {
            NotificationCenter.default.post(name: reachibilityConnection, object: nil, userInfo: ["connect":"Reachable via Cellular"])
            return true
        }
    } else {
        showToast(message: "Please turn on mobile data or connect to WiFi".localized())
        return false
    }
}

func checkInternetReachibility() {
    reachibility()
    reachability.whenReachable = { reachability in
        // this is called on a background thread, but UI updates must
        // be on the main thread, like this:
        DispatchQueue.main.async {
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
    }
    
    reachability.whenUnreachable = { reachability in
        // this is called on a background thread, but UI updates must
        // be on the main thread, like this:
        DispatchQueue.main.async {
            print("Not reachable")
        }
        
    }
}

func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

//MARK:- API

enum API_httpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum API_Error: Error {
    case NetworkNotAvailable
}

enum API_Content_Type: String {
    case json = "application/json"
    case x_www_form_urlencoded = "application/x-www-form-urlencoded"
    case none = ""
    
}

func data_request(extURLString:String , type:API_httpMethod, apiContentType :  API_Content_Type ,parameter:[String:Any]? ,tag:String, handler:@escaping (_ response:Any? , _ error:Error?,_ tag:String , _ statusCode:Int?)->Void) {
    
    if !isInternetAvailable() {
        handler(nil,API_Error.NetworkNotAvailable,tag,0)
//        showAlertMessage(string:"Check Your internet Connection".localized() , viewController: nil)
        
        return
    }
    
    if let url:URL = URL(string:BaseUrl + extURLString) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
//        if let sessionId = AppUserDefaults.getSessionId() { // Fld-Access-Token
//            request.setValue(sessionId, forHTTPHeaderField: "Token")
//        }
        if type != .none {
            request.setValue(apiContentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
        
        switch apiContentType {
        case .json:
            if let parameter = parameter {
                print(parameter)
                if let jsonData = try? JSONSerialization.data(withJSONObject: parameter, options: []) {
                    request.httpBody = jsonData
                }
            }
        case .x_www_form_urlencoded:
            if let parameter = parameter {
                let string = stringFromHttpParameters(data: parameter)
//                print(string)
                request.httpBody = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            }
        default:
            if let parameter = parameter {
                print(parameter)
                if let jsonData = try? JSONSerialization.data(withJSONObject: parameter, options: []) {
//                    print(parameter)
                    request.httpBody = jsonData
                }
            }
        }
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            let httpResponse = response as? HTTPURLResponse

            guard let data = data as Data?, let _:URLResponse = response, error == nil else {
                print("error")
                handler(nil,error,tag,httpResponse?.statusCode)
                return
            }
            do {
                let parseJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print(parseJson)
                if let err = parseJson as? [String:Any] {
                    if let errMessage = err["errMsg"] as? String, errMessage == "Access to the endpoint is not allowed for your role." || errMessage ==  "Please log in to view your items." {
//                        if let _ = AppUserDefaults.getSessionId() {
//                            if tag != "Upload" || tag != "SellDetail" {
//                                AppUserDefaults.setSessionId(sessionId: nil)
//                                AppUserDefaults.setUserDetail(data: nil)
//                                setViewControllerOnWindow(storyBoard: .main)
//                                return
//                            }
//                        }
                    }
                }
                
                handler(parseJson,nil,tag,httpResponse?.statusCode)
            }catch {
                print(error)
                handler(nil,error,tag,httpResponse?.statusCode)
            }
        }
        
        task.resume()
    }
}


func data_requestForDirectUrl(urlString:String , type:API_httpMethod ,parameter:[String:Any]? ,tag:String, handler:@escaping (_ response:Any? , _ error:Error?,_ tag:String , _ statusCode:Int?)->Void)
{
    
    if !isInternetAvailable() {
        handler(nil,API_Error.NetworkNotAvailable,tag,0)
        showToast(message: "Check Your internet Connection".localized())
        return
    }
    
    if let url:URL = URL(string:urlString) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        if type != .none {
            request.setValue(API_Content_Type.json.rawValue, forHTTPHeaderField: "Content-Type")
        }
        if let parameter = parameter {
            let string = convertJsonToString(data: parameter)
            print(string) // <-- here is ur string
            request.httpBody = string.data(using: .utf8)
        }
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            guard let data = data as Data?, let _:URLResponse = response, error == nil else {
                print("error")
                handler(nil,error,tag,httpResponse?.statusCode)
                return
            }
            do {
                let parseJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print(parseJson)
                handler(parseJson,nil,tag,httpResponse?.statusCode)
            }catch {
                print(error)
                handler(nil,error,tag,httpResponse?.statusCode)
            }
        }
        
        task.resume()
    }
}

//func uploadMediaWithAlamofire(urlString:String ,parameter:[String:Any]? ,images:[UIImage]?,tag:String, handler:@escaping (_ response:Any? , _ error:Error?,_ tag:String,_ statusCode:Int?)->Void) {
//    
//    guard isInternetAvailable() == true else {
//        handler(nil,nil,"",nil)
//        showAlertMessage(string: "Check Your internet Connection", viewController: nil)
//        return
//    }
//    
//    var header:[String:String]?
//    if let sessionId = AppUserDefaults.getSessionId() {
//        header = ["Token":sessionId] // Fld-Access-Token
//    }
//    
//    // application/octet-stream
//    
//    
//    Alamofire.upload(multipartFormData: { (multipartFormData) in
//        if let images = images {
//            var count = 0
//            for image in images {
//                multipartFormData.append(UIImagePNGRepresentation(image)!, withName: "files", fileName: "file\(count).png", mimeType: "image/png")
//                count += 1
//            }
//        }
//        
//        if let para = parameter {
//            for (key, value) in para {
//                if let value = value as? String {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                }
//                else {
//                    do {
//                        let data  = try JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted )
//                        multipartFormData.append(data, withName: key)
//                    } catch {
//                        print ("Error in parsing " )
//                    }
//                }
//            }
//        }
//    }, usingThreshold:UInt64.init(), to: BaseUrl + urlString, method: HTTPMethod.post, headers: header) { (encodingResult) in
//        switch encodingResult {
//        case .success(let upload, _, _):
//            upload.uploadProgress(closure: { (progress) in
//                //Print progress
//                print(progress)
//            })
//            upload.response(completionHandler: { (response) in
//                print(response)
//                do {
//                    let parseJson = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                    print(parseJson)
//                    handler(parseJson,nil,tag,response.response?.statusCode)
//                }catch {
//                    print(error)
//                    let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
//                    print(responseString)
//                    handler(responseString,response.error,tag,response.response?.statusCode)
//                }
//            })
//        case .failure(let encodingError):
//            print(encodingError)
//            handler(nil,encodingError,tag,nil)
//            break
//            //print encodingError.description
//        }
//    }
//    
//    /*
//    Alamofire.upload(multipartFormData: { (multipartFormData) in
//        if let images = images {
//            for image in images {
//                multipartFormData.append(UIImagePNGRepresentation(image)!, withName: "files", fileName: "swift_file.png", mimeType: "image/png")
//            }
//        }
//    }, to: BaseUrl + urlString) { (encodingResult) in
//        switch encodingResult {
//        case .success(let upload, _, _):
//            
//            upload.uploadProgress(closure: { (progress) in
//                //Print progress
//                print(progress)
//            })
//            
//            upload.response(completionHandler: { (response) in
//                print(response)
//                let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
//                print(responseString)
//                handler(responseString,response.error,tag,response.response?.statusCode)
//            })
//            
//        case .failure(let encodingError):
//            print(encodingError)
//            handler(nil,encodingError,tag,nil)
//            break
//            //print encodingError.description
//        }
//    }
//     */
//}


func query(parameter:[String:Any]) ->String {
    var component: [(String,String)] = []
    
    for key in parameter.keys {
        let value = parameter[key]!
        component += [(escape(string: key) , escape(string: value as! String))]
    }
    return (component.map{"\($0)=\($1)"} as [String]).joined(separator: "&")
}

func escape(string:String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
}


func stringFromHttpParameters(data:[String:Any]) -> String {
    
    let parametersString = convertJsonToString(data: data)
    return parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
}

func convertJsonToString(data:[String:Any]) -> String {
    var parametersString = ""
    for (key, value) in data {
        if let key = key as? String,
            let value = value as? String {
            parametersString = parametersString + key + "=" + value + "&"
        }
    }
    parametersString = parametersString.substring(to: parametersString.index(before: parametersString.endIndex))
    return parametersString
}
