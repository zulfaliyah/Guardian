//
//  API.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 09/01/21.
//

import Foundation
import KeychainAccess
import Alamofire
import SwiftyJSON

class API {
    
    let keychain = Keychain(server: "http://localhost:3000", protocolType: .http)

    func login (){
        let parameter: Parameters = [
            "username": UITextField.text,
            "password": UITextField.text
        ]

        AF.request("http://localhost:3000/api/v1/public/login", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                if let value = response.value {
                    let json = JSON(value)
                    let success = json["success"].boolValue
                    if success {
                        print (json["data"])
                        let keychain = API().keychain
                        keychain["token"] = String(describing: json["data"]["token"])
                        //performSegue(withIdentifier: toMain, sender: self)
                        
                        
                    } else {
                        let message = json["errorMessage"].stringValue
                        print (message)
                    }
                }
                        
        }
    }

}
