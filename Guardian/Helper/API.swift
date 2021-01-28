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
    let server = "http://grainy.id/api/v1/"
    let keychain = Keychain(server: "http://grainy.id", protocolType: .http)
    
    func checkToken() {
        if let key = keychain["token"] {
            print (key)
        } else {
            print (keychain["token"] ?? "nil" )
            alert(message: "Token tidak tersimpan, silakan login kembali", title: "Tidak ada Token")
            move(name: "Login", identifier: "Login")
        }
    }
    
    func login (username: String, password: String){
        let parameter: Parameters = [
            "username": username,
            "password": password
        ]
        print (parameter)

        AF.request( server + "public/login", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .responseJSON { [self] response in
                if let value = response.value {
                    let json = JSON(value)
                    let success = json["success"].boolValue
                    let level = json["data"]["user"]["level"].stringValue
                    if success {
                        print (json["data"])
                        let key = keychain
                        key["token"] = String(describing: json["data"]["token"])
                        UserDefaults.standard.set(level, forKey: "userLevel")
                        if level == "0" {
                            let storyboard = UIStoryboard(name: "AdminMain", bundle: nil)
                                let AdminMain = storyboard.instantiateViewController(identifier: "AdminMain")
                            
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(AdminMain)
                        } else if level == "1" {
                            
                            let storyboard = UIStoryboard(name: "NasabahMain", bundle: nil)
                                let NasabahMain = storyboard.instantiateViewController(identifier: "NasabahMain")
                            //self.navigationController?.pushViewController(NasabahMain, animated: true)
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(NasabahMain)
                        } else {
                            print("not admin or nasabah")
                        }
                        
                        
                        
                    } else {
                        let message = json["errorMessage"].stringValue
                        print (message)
                        alert(message: "Silakan ulangi proses login", title: "Username atau password salah")
                    }
                }
        }
    }
    
    func daftar (fullname: String, username: String, password: String, phone:String){
        let parameter: Parameters = [
            "fullname": fullname,
            "username": username,
            "password": password,
            "phone": phone
        ]
        print (parameter)

        AF.request( server + "public/register", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .responseJSON { [self] response in
                if let value = response.value {
                    let json = JSON(value)
                    let success = json["success"].boolValue
                    if success {
                        print (json["data"])
                        alert(message: "Silakan login menggunakan akun baru anda", title: "Selamat menjadi nasabah!")
                        move(name: "Login", identifier: "Login")
                    } else {
                        let message = json["errorMessage"].stringValue
                        print (message)
                        alert(message: "Silakan ulangi proses pendaftaran", title: "Data tidak tersimpan")
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
    
    //nasabah
    
    func profil (completion: @escaping(_ error: Error?, _ nasabahProfile: NasabahProfile?) ->Void) {
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "profile", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in
                switch response.result{
                            case .failure(let error):
                                completion(error, nil)
                                print(error)

                            case .success(let value):
                                let json = JSON(value)
                                print(json)

                            guard let dataDict = json["data"]["user"].dictionaryObject else{
                                completion(nil, nil)
                                return
                            }
                                let nasabahProfile = NasabahProfile(dict: dataDict)
                            completion(nil, nasabahProfile)
                        }
        }
    }
    
    
    
    func setorScan (machineID: String, completion: @escaping(_ error: Error?, _ scan: Scan?) ->Void) {
        let parameter: Parameters = [
            "machineID": machineID
        ]
        print (parameter)
        
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "machine/scan/", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                            case .failure(let error):
                                completion(error, nil)
                                print(error)

                            case .success(let value):
                                let json = JSON(value)
                                print(json)
                                let key = self.keychain
                                key["token"] = String(describing: json["data"]["token"])

                            guard let dataDict = json["data"].dictionaryObject else{
                                completion(nil, nil)
                                return
                            }
                                let scan = Scan(dict: dataDict)
                            completion(nil, scan)
                        }
        }
    }
    
    func cairkan (amount: String, completion: @escaping(_ error: Error?, _ trxProfile: TrxProfile?) ->Void) {
        let parameter: Parameters = [
            "amount": amount
        ]
        print (parameter)
        
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "disbursement-request", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                            case .failure(let error):
                                completion(error, nil)
                                print(error)

                            case .success(let value):
                                let json = JSON(value)
                                print(json)

                            guard let dataDict = json["data"].dictionaryObject else{
                                completion(nil, nil)
                                return
                            }
                                let trxProfile = TrxProfile(dict: dataDict)
                            completion(nil, trxProfile)
                        }
        }
    }
    
    //admin
    func jumlahNasabah (completion: @escaping(_ error: Error?, _ totalNasabah: TotalNasabah?) ->Void){
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)
        
        AF.request( server + "admin/customercount", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in
                switch response.result{
                            case .failure(let error):
                                completion(error, nil)
                                print(error)

                            case .success(let value):
                                let json = JSON(value)
                                print(json)

                            guard let dataDict = json["data"].dictionaryObject else{
                                completion(nil, nil)
                                return
                            }
                                let totalNasabah = TotalNasabah(dict: dataDict)
                            completion(nil, totalNasabah)
                }
        }
    }
    
    func jumlahSampah (completion: @escaping(_ error: Error?, _ totalSampah: TotalSampah?) ->Void){
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)
        
        AF.request( server + "admin/today-deposit", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in
                switch response.result{
                            case .failure(let error):
                                completion(error, nil)
                                print(error)

                            case .success(let value):
                                let json = JSON(value)
                                print(json)

                            guard let dataDict = json["data"].dictionaryObject else{
                                completion(nil, nil)
                                return
                            }
                                let totalSampah = TotalSampah(dict: dataDict)
                            completion(nil, totalSampah)
                }
        }
    }
    
    func nasabahAdminProfil (userId: Int, completion: @escaping(_ error: Error?, _ nasabahAdmProfile: NasabahAdmProfile?) ->Void) {
        let parameter: Parameters = [
            "userId": userId
        ]
        print (parameter)
        
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "admin/user-detail", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in
                switch response.result{
                            case .failure(let error):
                                completion(error, nil)
                                print(error)

                            case .success(let value):
                                let json = JSON(value)
                                print(json)

                            guard let dataDict = json["data"].dictionaryObject else{
                                completion(nil, nil)
                                return
                            }
                            
                            let nasabahAdmProfile = NasabahAdmProfile(dict: dataDict)
                            completion(nil, nasabahAdmProfile)
                        }
        }
    }
    
    func AdminPencairan (disbursementCode: String, completion: @escaping(_ error: Error?, _ pencairan: Pencairan?) ->Void) {
        let parameter: Parameters = [
            "disbursementCode": disbursementCode
        ]
        print (parameter)
        
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "admin/disbursement-approval", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result{
                            case .failure(let error):
                                completion(error, nil)
                                print(error)

                            case .success(let value):
                                let json = JSON(value)
                                print(json)

                            guard let dataDict = json["data"].dictionaryObject else{
                                completion(nil, nil)
                                return
                            }
                                let pencairan = Pencairan(dict: dataDict)
                            completion(nil, pencairan)
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
//            self.present(newViewController, animated: true, completion: nil)
            //self.getTopMostViewController()?.navigationController?.pushViewController(vc, animated: true)
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


