//
//  APIClient.swift
//  HieCOR
//
//  Created by HyperMacMini on 24/11/17.
//  Copyright © 2017 HyperMacMini. All rights reserved.
//

import Foundation
import Alamofire

class APICall {
    static func APICallGETMethod(stringUrl: String, withCompletionHandler:@escaping (_ response:Any)->Void)
    {
        if NetworkConnectivity.isConnectedToInternet()
        {
            let defaults = UserDefaults.standard
            var str_UserName = String()
            var str_AuthKey = String()
            if (defaults.object(forKey: "auth_key") != nil) {
                str_AuthKey = defaults.object(forKey: "auth_key") as! String
            }
            
            if (defaults.object(forKey: "user_name") != nil) {
                str_UserName = defaults.object(forKey: "user_name") as! String
            }
            var UserID = String()
            if (UserDefaults.standard.object(forKey: "userID") != nil) {
                UserID = (UserDefaults.standard.object(forKey: "userID")as AnyObject).object(at: 0) as! String
            }
            let headers = ["Content-Type": "application/json", "X-USERNAME":str_UserName, "X-AUTH-KEY":str_AuthKey, "X-AGENT-ID":UserID]
            print(headers)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.show_LoadingIndicator()
            Alamofire.request(stringUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
//                appDelegate.hide_LoadingIndicator()
                print("Request: \(String(describing: response.request))")   // original url request
                print("Request Headers: \(String(describing: response.request?.allHTTPHeaderFields))")
                print("Response: \(String(describing: response.response))") // http url response-
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    withCompletionHandler(response.result.value!)
                }
                else
                {
                    print(response.result.isFailure)
                    withCompletionHandler(response.result.isFailure)
                }
            }
        }
        else
        {
            let uiAlertController = UIAlertController(title: "Alert", message: "Please check your internet connection", preferredStyle:.alert)
            uiAlertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (UIAlertAction) in
                uiAlertController.dismiss(animated: true, completion: nil)
            }))
            //            self.present(uiAlertController, animated: true, completion: nil)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(uiAlertController, animated: true, completion: nil)
        }
        
    }
    static func APICallPOSTMethod(stringUrl:String, body :Parameters, withCompletionHandler:@escaping (_ response:Any)->Void)
    {
        if NetworkConnectivity.isConnectedToInternet()
        {
            let defaults = UserDefaults.standard
            var str_UserName = String()
            var str_AuthKey = String()
            if (defaults.object(forKey: "auth_key") != nil) {
                str_AuthKey = defaults.object(forKey: "auth_key") as! String
            }
            if (defaults.object(forKey: "user_name") != nil) {
                str_UserName = defaults.object(forKey: "user_name") as! String
            }
            var UserID = String()
            if (UserDefaults.standard.object(forKey: "userID") != nil) {
                UserID = (UserDefaults.standard.object(forKey: "userID")as AnyObject).object(at: 0) as! String
            }
            let headers = ["Content-Type": "application/json", "X-USERNAME":str_UserName, "X-AUTH-KEY":str_AuthKey, "X-AGENT-ID":UserID]
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.show_LoadingIndicator()
            
            Alamofire.request(stringUrl, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                
//                appDelegate.hide_LoadingIndicator()
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response-
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    withCompletionHandler(response.result.value!)
                }
                else
                {
                    withCompletionHandler(response.result.isFailure)
                }
                
                //            if response.result.isFailure {
                //                if let error = response.result.error as? AFError, error.responseCode == 499 {
                //                    //INVALID SESSION RESPONSE
                //                } else {
                //                    //NETWORK FAILURE
                //                }
                //            }
                
                
            }
        }else
        {
            let uiAlertController = UIAlertController(title: "Alert", message: "Please check your internet connection", preferredStyle:.alert)
            uiAlertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (UIAlertAction) in
                uiAlertController.dismiss(animated: true, completion: nil)
            }))
            //            self.present(uiAlertController, animated: true, completion: nil)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(uiAlertController, animated: true, completion: nil)
        }
        
        
    }
    
    static func APICallPUTMethod(stringUrl:String, body :Parameters, withCompletionHandler:@escaping (_ response:Any)->Void)
    {
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.show_LoadingIndicator()
        Alamofire.request(stringUrl, method: .put, parameters: body, encoding: URLEncoding.default, headers: headers).responseJSON { response in
//            appDelegate.hide_LoadingIndicator()
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response-
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                withCompletionHandler(response.result.value!)
            }
            else
            {
                withCompletionHandler(response.result)
            }
            
        }
    }
    
    static func APICallDELETEMethod(urlString:String, body :Parameters, withCompletionHandler:@escaping (_ response:Any)->Void)
    {
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.show_LoadingIndicator()
        Alamofire.request(urlString, method: .delete, parameters: body ,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
//            appDelegate.hide_LoadingIndicator()
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response-
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                withCompletionHandler(response.result.value!)
            }
            else
            {
                withCompletionHandler(response.result)
            }
        }
    }
    
    static func APICallGETMethodForOfflineData(stringUrl: String, withCompletionHandler:@escaping (_ response:Any)->Void)
    {
        let defaults = UserDefaults.standard
        var str_UserName = String()
        var str_AuthKey = String()
        if (defaults.object(forKey: "auth_key") != nil) {
            str_AuthKey = defaults.object(forKey: "auth_key") as! String
        }
        
        if (defaults.object(forKey: "user_name") != nil) {
            str_UserName = defaults.object(forKey: "user_name") as! String
        }
        var UserID = String()
        if (UserDefaults.standard.object(forKey: "userID") != nil) {
            UserID = (UserDefaults.standard.object(forKey: "userID")as AnyObject).object(at: 0) as! String
        }
        let headers = ["Content-Type": "application/json", "X-USERNAME":str_UserName, "X-AUTH-KEY":str_AuthKey, "X-AGENT-ID":UserID]
        print(headers)
        Alamofire.request(stringUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Request Headers: \(String(describing: response.request?.allHTTPHeaderFields))")
            print("Response: \(String(describing: response.response))") // http url response-
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                withCompletionHandler(response.result.value!)
            }
            else
            {
                print(response.result.isFailure)
                withCompletionHandler(response.result.isFailure)
            }
        }
    }
}
