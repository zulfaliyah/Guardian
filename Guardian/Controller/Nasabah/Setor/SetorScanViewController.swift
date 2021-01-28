//
//  SetorScanViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import MercariQRScanner
import UIKit



class SetorScanViewController: UIViewController, QRScannerViewDelegate {
    
    func dismiss() {
        print("dismiss")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    var berhasilVC = BerhasilViewController()
    
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
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //berhasilVC.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissController), name:NSNotification.Name(rawValue: "dismissBerhasilVC"), object: nil)

    }
    
    @objc func dismissController() {
        print("dismiss")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        qrScannerView.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("asdf")
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        propertyView.isHidden = true
        API().setorScan(machineID: code){ (error: Error?, scanData: Scan?) in
                if let scanData = scanData {
                    print(scanData.userID)

                }
            self.setupSetorDetail()
        }
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }
        
    func setupSetorDetail() {
        let vc = SetorDetailViewController(nibName:"SetorDetailViewController", bundle:nil)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        vc.view.clipsToBounds = false
        print("setordetail")
    }
    
    
}

