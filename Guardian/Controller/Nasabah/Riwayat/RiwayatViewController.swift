//
//  RiwayatViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess

struct Riwayat {
    var tanggal: String?
    var botol: String?
    var uang: String?
}

class RiwayatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    let server = "http://grainy.id/api/v1/"
    let keychain = Keychain(server: "http://grainy.id", protocolType: .http)
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var handlePin: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySeg: UISegmentedControl!
    @IBAction func segAction(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex { // use the `sender` parameter rather than the outlet reference
            case 0:
                riwayatTransaksi(trxType: 0)
            case 1:
                riwayatTransaksi(trxType: 1)
            default:
                break
        }
        
        tableView.reloadData()
    }

    var image = UIImage(named: "setor")
    var image1 = UIImage(named: "cair")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handlePin.layer.cornerRadius = handlePin.frame.height / 2
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RiwayatItemTableViewCell", bundle: nil), forCellReuseIdentifier: "setorCell")
        tableView.register(UINib(nibName: "RiwayatPencairanTableViewCell", bundle: nil), forCellReuseIdentifier: "cairCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        riwayatTransaksi(trxType: 0)
    }
    
    var jsonData = [Riwayat]()
    
    func riwayatTransaksi(trxType: Int){
        self.jsonData=[]
        
        let parameter: Parameters = [
            "trxType": trxType
        ]
        print (parameter)
        
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "transaction-list", method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in
                
                if let value = response.value{
                    let json = JSON(value)
                    let results = json["data"].arrayValue
                        for result in results {
                            let botol = result["quantity"].stringValue
                            let uang = result["amount"].stringValue
                            let tanggal = result["created_at"].stringValue
                            self.jsonData.append(Riwayat(tanggal: tanggal, botol: botol, uang: uang))
                            print(self.jsonData)
                            self.tableView.reloadData()
                        }

                    self.tableView.reloadData()
                }
                self.tableView.reloadData()
        }
        
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(jsonData.count)
        return jsonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedIndex = self.mySeg.selectedSegmentIndex
        switch selectedIndex {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "setorCell", for: indexPath) as! RiwayatItemTableViewCell
                cell.selectionStyle = .none
                        cell.uangImg.image = self.image
                        cell.tanggalLabel.text = jsonData[indexPath.row].tanggal!
                        cell.botolLabel.text = jsonData[indexPath.row].botol! + " botol"
                        cell.uangLabel.text = "Rp " + jsonData[indexPath.row].uang!
                        
        return cell
            case 1:
                print(jsonData[0].tanggal!)
                let cell = tableView.dequeueReusableCell(withIdentifier: "cairCell", for: indexPath) as! RiwayatPencairanTableViewCell
                cell.selectionStyle = .none
                cell.uangImgCair.image = self.image1
                cell.tanggalLabelCair.text = jsonData[indexPath.row].tanggal!
                cell.uangLabelCair.text = "Rp " + jsonData[indexPath.row].uang!
                return cell
            default: break
         }
        return UITableViewCell()
    }

}


