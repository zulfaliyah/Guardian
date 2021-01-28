//
//  SetorDetailViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 11/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess

class SetorDetailViewController: UIViewController{

//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    func appDelegate.StartMQTT()
    let server = "http://grainy.id/api/v1/"
    let keychain = Keychain(server: "http://grainy.id", protocolType: .http)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cardHeight: CGFloat = 600
    var cardHandleAreaHeight: CGFloat = 600
    @IBOutlet weak var viewName: UIView!
    
    @IBAction func selesai(_ sender: Any) {
        print("selesai btn")
        print(appDelegate.machine_id)
        //viewName.removeFromSuperview()
        UIView.animate(withDuration: 0.5) {
                    self.viewName.center.y += 87
                }
        akhiriSesi(machineID: appDelegate.machine_id, trxID: appDelegate.setor_id)
        
//
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.viewName.center.y -= self.viewName.frame.height
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func akhiriSesi(machineID: String, trxID: Int){
        
        let parameter: Parameters = [
            "machineID": machineID,
            "trxID": trxID
        ]
        print (parameter)
        
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "machine/terminate-session",  method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in
                if let value = response.value{
                    let json = JSON(value)
                    let success = json["success"].boolValue
                    if success {
                        let jumlah0 = json["data"]["trxDetail"]["0"]["count"].stringValue
                        let harga0 = json["data"]["trxDetail"]["0"]["depositValue"].stringValue
                        let jumlah1 = json["data"]["trxDetail"]["1"]["count"].stringValue
                        let harga1 = json["data"]["trxDetail"]["1"]["depositValue"].stringValue
                        let jumlah2 = json["data"]["trxDetail"]["2"]["count"].stringValue
                        let harga2 = json["data"]["trxDetail"]["2"]["depositValue"].stringValue
                        
                        self.appDelegate.jumlah0 = jumlah0
                        self.appDelegate.harga0 = harga0
                        self.appDelegate.jumlah1 = jumlah1
                        self.appDelegate.harga1 = harga1
                        self.appDelegate.jumlah2 = jumlah2
                        self.appDelegate.harga2 = harga2
                        
                        self.setupDetail()
                    } else {
                        let message = json["errorMessage"].stringValue
                        print (message)
                        self.alert(message: message, title: "Error")
                    }
                    
                    
                }
        }
    }
    
    override func viewDidLoad() {
        appDelegate.StartMQTT()
//        if appDelegate.sessionCanceled {
//            alertHome(message: "Tidak ada aktivitas terdeteksi", title: "Sesi dihentikan")
//        }
    }
    
    
    func setupDetail() {
        print("setup detail")
        let vc = DetailTransaksiViewController(nibName:"DetailTransaksiViewController", bundle:nil)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        vc.view.clipsToBounds = false
    }
}

