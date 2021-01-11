//
//  RiwayatViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import UIKit

class RiwayatViewController: UIViewController {
    

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var handlePin: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySeg: UISegmentedControl!
    
    @IBAction func segAction(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    var estimateWidth = 140.0
    var cellMarginSize = 20.0
    
    var image = UIImage(named: "setor")
    var tanggal:[String] = ["1 Desember 2020", "2 Desember 2020", "3 Desember 2020"]
    var botol:[String] = ["2", "3", "4"]
    var uang:[String] = ["1000", "2000", "3000"]
    
    var image1 = UIImage(named: "cair")
    var tanggal1:[String] = ["21 Desember 2020", "21 Desember 2020", "31 Desember 2020"]
    var botol1:[String] = ["21", "31", "41"]
    var uang1:[String] = ["11000", "21000", "31000"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handlePin.layer.cornerRadius = handlePin.frame.height / 2
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RiwayatItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension RiwayatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RiwayatItemTableViewCell
        cell.selectionStyle = .none
        
        let selectedIndex = self.mySeg.selectedSegmentIndex
        switch selectedIndex
            {
            case 0:
                cell.uangImg.image = image
                cell.tanggalLabel.text = tanggal[indexPath.row]
                cell.tanggalLabel.text = tanggal[indexPath.row]
                cell.botolLabel.text = botol[indexPath.row]+" Botol"
                cell.uangLabel.text = "+ " + uang[indexPath.row]
            case 1:
                cell.uangImg.image = image1
                cell.tanggalLabel.text = tanggal1[indexPath.row]
                cell.botolLabel.text = botol1[indexPath.row]+" Botol"
                cell.uangLabel.text = "+ " + uang1[indexPath.row]
            default:
                return cell
            }
        return cell
        
    }
}

extension RiwayatViewController: UITableViewDelegate{
    
}

