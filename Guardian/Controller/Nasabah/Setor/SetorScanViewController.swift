//
//  SetorScanViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import MercariQRScanner
import UIKit


class SetorScanViewController: UIViewController, QRScannerViewDelegate {
    
    var setorDetailViewController: SetorDetailViewController!
    var cardHeight: CGFloat = 600
    var cardHandleAreaHeight: CGFloat = 420
    @IBOutlet weak var propertyView: UIView!
    
    @IBOutlet weak var qrScannerView: QRScannerView!{
        didSet {
            qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let qrScannerView = QRScannerView(frame: view.bounds)
        qrScannerView.focusImage = UIImage(named: "scan_qr_focus")
        qrScannerView.focusImagePadding = 8.0
        qrScannerView.animationDuration = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        qrScannerView.startRunning()
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        propertyView.isHidden = true
        API().setorScan(machineID: code)
        setupCard()
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }
    
    

}

extension SetorScanViewController  {
    func setupCard() {
        setorDetailViewController = SetorDetailViewController(nibName:"SetorDetailViewController", bundle:nil)
        //self.addChild(setorDetailViewController)
        self.view.addSubview(setorDetailViewController.view)
        setorDetailViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        setorDetailViewController.view.clipsToBounds = false
    }
    

    
}

