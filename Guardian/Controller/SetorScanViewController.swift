//
//  SetorScanViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import MercariQRScanner
import UIKit


class SetorScanViewController: UIViewController, QRScannerViewDelegate {
    
    @IBOutlet weak var qrScannerView: QRScannerView!{
        didSet {
            qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        }
    }
    
    @IBOutlet weak var close: UIButton!
    
    
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
//        if let url = URL(string: code), (url.scheme == "http" || url.scheme == "https") {
//            openWeb(url: url)
//        } else {
//            showAlert(code: code)
//        }
        API().setorScan(machineID: code)
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }
}

private extension SetorScanViewController {
    func openWeb(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: { _ in
            self.qrScannerView.rescan()
        })
    }

    func showAlert(code: String) {
        let alertController = UIAlertController(title: code, message: nil, preferredStyle: .actionSheet)
        let copyAction = UIAlertAction(title: "Copy", style: .default) { [weak self] _ in
            UIPasteboard.general.string = code
            self?.qrScannerView.rescan()
        }
        alertController.addAction(copyAction)
        let searchWebAction = UIAlertAction(title: "Search Web", style: .default) { [weak self] _ in
            UIApplication.shared.open(URL(string: "https://www.google.com/search?q=\(code)")!, options: [:], completionHandler: nil)
            self?.qrScannerView.rescan()
        }
        alertController.addAction(searchWebAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
            self?.qrScannerView.rescan()
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

