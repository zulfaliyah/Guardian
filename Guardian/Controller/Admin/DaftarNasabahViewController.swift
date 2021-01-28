//
//  DaftarNasabahViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 16/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainAccess

struct NamaNasabah {
    var userId: Int
    var nama: String
    var saldo: String
    var nomor: String
}

class DaftarNasabahViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let server = "http://grainy.id/api/v1/"
    let keychain = Keychain(server: "http://grainy.id", protocolType: .http)
    var jsonData = [NamaNasabah]()

    //@IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "Hijau");
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(named: "Hijau") ?? UIColor.init(named: "Hijau")]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allUser()
    }
    
    func allUser(){
        self.jsonData=[]
        
        let header : HTTPHeaders = [
            "g-token" : keychain["token"] ?? ""
        ]
        print (header)

        AF.request( server + "admin/allusers", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .responseJSON {  response in
                
                if let value = response.value{
                    let json = JSON(value)
                    let results = json["data"]["users"]["rows"].arrayValue
                        for result in results {
                            let userId = result["id"].intValue
                            let nama = result["fullname"].stringValue
                            let saldo = result["balance"].stringValue
                            let nomor = result["phone"].stringValue
                            self.jsonData.append(NamaNasabah(userId: userId, nama: nama, saldo: saldo, nomor: nomor))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "nasabahCell", for: indexPath) as! DaftarNasabahCell
                cell.selectionStyle = .none
        cell.namaLabel.text = jsonData[indexPath.row].nama
                        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(jsonData[indexPath.row].userId)
//        print("teken")
//        let secondVC = RekeningNasabah()
        appDelegate.nasabah_id = self.jsonData[indexPath.row].userId
        let storyboard = UIStoryboard(name: "Rekening", bundle: nil)
        let controller = (storyboard.instantiateViewController(withIdentifier: "RekeningNasabah")) as! RekeningNasabah
        self.navigationController?.pushViewController(controller, animated: true)
//        let sb = UIStoryboard.init(name: "Rekening", bundle:     nil)
//        let destinationVC = sb.instantiateViewController(withIdentifier: "RekeningNasabah") as! RekeningNasabah
//        guard let id = jsonData[indexPath.row]?.userId else {return}
//        destinationVC.id = id
//        self.navigationController.pushViewController(destinationVC ?? nil, animated: true)
        //self.performSegue(withIdentifier: "toRekeningNasabah", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toRekeningNasabah" {
//
//            let destVC = segue.destination as! UINavigationController
//            let VC = destVC.topViewController as! RekeningNasabah
//            VC.id = self.jsonData[indexPath.row].userId
//        }
//        if let indexPath = tableView.indexPathForSelectedRow{
//            let selectedRow = indexPath.row
//            let destVC = segue.destination as! UINavigationController
//            let VC = destVC.topViewController as! RekeningNasabah
//            VC.id = self.jsonData[selectedRow].userId
//            //let VC = sb.instantiateViewController(withIdentifier: "RekeningNasabah") as! RekeningNasabah
//        }
    }
}

class DaftarNasabahCell: UITableViewCell {
    @IBOutlet weak var namaLabel: UILabel!
}
