//
//  DetailTransaksiViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 11/01/21.
//

import UIKit

class DetailTransaksiViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var jumlah0: UILabel!
    @IBOutlet weak var harga0: UILabel!
    @IBOutlet weak var jumlah1: UILabel!
    @IBOutlet weak var harga1: UILabel!
    @IBOutlet weak var jumlah2: UILabel!
    @IBOutlet weak var harga2: UILabel!
    @IBOutlet weak var total: UILabel!
    
    
    
    var berhasilViewController: BerhasilViewController!
    var cardHeight: CGFloat = 600
    var cardHandleAreaHeight: CGFloat = 600
    
    @IBOutlet var transaksiView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.transaksiView.center.y -= self.transaksiView.frame.height
        }
        
        jumlah0.text = "x " + appDelegate.jumlah0
        harga0.text = "Rp " + appDelegate.harga0
        jumlah1.text = "x " + appDelegate.jumlah1
        harga1.text = "Rp " + appDelegate.harga1
        jumlah2.text = "x " + appDelegate.jumlah2
        harga2.text = "Rp " + appDelegate.harga2

        let hargaInt0 = Int(appDelegate.harga0) ?? 0
        let hargaInt1 = Int(appDelegate.harga1) ?? 0
        let hargaInt2 = Int(appDelegate.harga2) ?? 0
        let totalHarga = hargaInt0 + hargaInt1 + hargaInt2
        appDelegate.TotalHarga = totalHarga
        total.text = "Rp" + String(totalHarga)
        print(totalHarga)
    }
    @IBAction func tabungBtn(_ sender: Any) {
        print("berhasil")
        UIView.animate(withDuration: 0.5) {
            self.transaksiView.center.y -= 100
        }
        setupCard()

    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
//        jumlah0.text = "x "
//                harga0.text = "Rp "
//                jumlah1.text = "x "
//                harga1.text = "Rp "
//                jumlah2.text = "x "
//                harga2.text = "Rp "
        
    }
    
    func setupCard() {
        print("setup detail")
        let vc = BerhasilViewController(nibName:"BerhasilViewController", bundle:nil)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        vc.view.clipsToBounds = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("asdf")
    }
}
