//
//  SetorDetailViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 11/01/21.
//

import UIKit

class SetorDetailViewController: UIViewController {
    var detailTransaksiViewController: DetailTransaksiViewController!
    var setorDetailViewController: SetorDetailViewController!
    var setorScanViewController: SetorScanViewController!
    var cardHeight: CGFloat = 600
    var cardHandleAreaHeight: CGFloat = 600
    
    @IBOutlet weak var viewName: UIView!
    @IBAction func selesaiBtn(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.viewName.center.y += self.viewName.frame.height  - 520
        }
        setupCard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.viewName.center.y -= self.viewName.frame.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    func setupCard() {
        detailTransaksiViewController = DetailTransaksiViewController(nibName:"DetailTransaksiViewController", bundle:nil)
        //self.addChild(detailTransaksiViewController)
        self.view.addSubview(detailTransaksiViewController.view)
        detailTransaksiViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        detailTransaksiViewController.view.clipsToBounds = false
    }
    
//    func dismissCard(){
//        setorDetailViewController = SetorDetailViewController(nibName:"SetorDetailViewController", bundle:nil)
//        //setorDetailViewController.willMove(toParent: setorScanViewController)
//        //setorDetailViewController.view.removeFromSuperview()
//        setorDetailViewController.removeFromParent()
//        viewName.removeFromSuperview()
//        
//    }
}


