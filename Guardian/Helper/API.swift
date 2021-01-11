//
//  API.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 09/01/21.
//

import UIKit
import KeychainAccess
import Alamofire
import SwiftyJSON

class API: UIViewController {

    let keychain = Keychain(server: "http://192.168.1.3:3000", protocolType: .http)
    
    
    func checkToken() {
        if let keychain = API().keychain["token"] {
            print (keychain)
        } else {
            print (API().keychain["token"] ?? "nil" )
            move(name: "Login", identifier: "Login")
        }
    }
    
    func login (username: String, password: String){
        let parameter: Parameters = [
            "username": username,
            "password": password
        ]
        print (parameter)

        AF.request("http://192.168.1.3:3000/api/v1/public/login", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .responseJSON { [self] response in
                if let value = response.value {
                    let json = JSON(value)
                    let success = json["success"].boolValue
                    let level = json["data"]["user"]["level"].stringValue
                    if success {
                        print (json["data"])
                        let keychain = API().keychain
                        keychain["token"] = String(describing: json["data"]["token"])
                        //keychain["level"] = String(describing: json["data"]["user"]["level"])
                        UserDefaults.standard.set(level, forKey: "userLevel")
                        if level == "0" {
                            move(name: "AdminMain", identifier: "AdminMain")
                        } else if level == "2" {
                            move(name: "NasabahMain", identifier: "NasabahMain")
                        }
                    } else {
                        let message = json["errorMessage"].stringValue
                        print (message)
                    }
                }
        }
    }
    
    func logout (){
        do {
            try keychain.remove("token")
            move(name: "Login", identifier: "Login")
        } catch let error {
            print("error: \(error)")
        }
    }
    
    func setorScan(machineID: String){
        let parameter: Parameters = [
            "machineID": machineID
        ]
        print (parameter)
        
        let headers : HTTPHeaders = [
            "g-token" : keychain["token"] ?? "",
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
        print (headers)

        AF.request("http://192.168.1.3:3000/api/v1/machine/scan", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                if let value = response.value {
                    let json = JSON(value)
                    let success = json["success"].boolValue
                    if success {
                        print (json)
                    } else {
                        let message = json["errorMessage"].stringValue
                        print (message)
                    }
                }
        }
    }
}

extension UIViewController{
    func move(name: String, identifier: String) {
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: identifier )
        
        DispatchQueue.main.async {
            self.getTopMostViewController()?.present(vc, animated: true, completion: nil)
        }
    }
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController

        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
    
    
}


