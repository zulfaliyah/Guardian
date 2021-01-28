//
//  KapasitasViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 16/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess

struct capacity {
    var persen: Int
    var nama: String
}

class KapasitasViewController: UIViewController{

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var handlePin: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var kapasitasTable: UITableView!
    
    let server = "http://grainy.id/api/v1/"
    let keychain = Keychain(server: "http://grainy.id", protocolType: .http)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handlePin.layer.cornerRadius = handlePin.frame.height / 2
        
        kapasitasTable.delegate = self
        kapasitasTable.dataSource = self
        
        kapasitasTable.register(UINib(nibName: "KapasitasItemTableViewCell", bundle: nil), forCellReuseIdentifier: "kapasitasCell")
        
        kapasitas()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.kapasitasTable.reloadData()
        }
    }
    
    var jsonData = [capacity]()
    
    func kapasitas(){
        self.jsonData=[]
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "admin/all-capacity", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in

                if let value = response.value{
                    let json = JSON(value)
                    let results = json["data"]["machines"]["rows"].arrayValue
                        for result in results {
                            let nama = result["name"].stringValue
                            let persen = result["capacity"].intValue
                            self.jsonData.append(capacity(persen: persen, nama: nama))
                            print(self.jsonData)
                            self.kapasitasTable.reloadData()
                        }

                    self.kapasitasTable.reloadData()
                }
                self.kapasitasTable.reloadData()
        }

        self.kapasitasTable.reloadData()
    }
    
//    var namaTong = "Tong Sampah Sei Jang"
//    var kapasitasTong = "5"
}

extension KapasitasViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kapasitasCell", for: indexPath) as! KapasitasItemTableViewCell
        cell.selectionStyle = .none
        
        cell.namaTong.text = jsonData[indexPath.row].nama
        cell.kapasitasTong.text = String(jsonData[indexPath.row].persen) + " %"
        print(jsonData[indexPath.row].nama)
        return cell
    }
}

extension KapasitasViewController: UITableViewDelegate{
    
}


