//
//  DetailTransaksiViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 11/01/21.
//

import UIKit

class DetailTransaksiViewController: UIViewController {
    var berhasilViewController: BerhasilViewController!
    var cardHeight: CGFloat = 750
    var cardHandleAreaHeight: CGFloat = 700
    
    @IBOutlet var transaksiView: UIView!
    @IBAction func selesaiBtn(_ sender: Any) {
        setupCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.transaksiView.center.y -= self.transaksiView.frame.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupCard() {
        berhasilViewController = BerhasilViewController(nibName:"BerhasilViewController", bundle:nil)
        self.view.addSubview(berhasilViewController.view)
        berhasilViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        berhasilViewController.view.clipsToBounds = false
    }
}
