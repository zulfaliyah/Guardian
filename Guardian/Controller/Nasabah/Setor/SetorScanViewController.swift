//
//  SetorScanViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import MercariQRScanner
import UIKit


class SetorScanViewController: UIViewController, QRScannerViewDelegate {
    
    var visualEffectView: UIVisualEffectView!
    var setorDetailViewController: SetorDetailViewController!
    var cardHeight: CGFloat = 600
    var cardHandleAreaHeight: CGFloat = 420
    
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
//        if let url = URL(string: code), (url.scheme == "http" || url.scheme == "https") {
//            openWeb(url: url)
//        } else {
//            showAlert(code: code)
//        }
        API().setorScan(machineID: code)
        setupCard()
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        setorDetailViewController = SetorDetailViewController(nibName:"SetorDetailViewController", bundle:nil)
        self.addChild(setorDetailViewController)
        self.view.addSubview(setorDetailViewController.view)
        setorDetailViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
    
        setorDetailViewController.view.clipsToBounds = true
    }

//    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            // set animation
//            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.riwayatViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
//                case .collapsed:
//                    self.riwayatViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
//                }
//            }
//            // when animation complete
//            frameAnimator.addCompletion { _ in
//                self.cardVisible = !self.cardVisible
//                self.runningAnimations.removeAll()
//            }
//            // start animation
//            frameAnimator.startAnimation()
//            runningAnimations.append(frameAnimator)
//
//            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
//                case .collapsed:
//                    self.visualEffectView.effect = nil
//                }
//            }
//
//            blurAnimator.startAnimation()
//            runningAnimations.append(blurAnimator)
//
//        }
//    }
//
//    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            animateTransitionIfNeeded(state: state, duration: duration)
//        }
//        for animator in runningAnimations {
//            animator.pauseAnimation()
//            animationProgressWhenInterrupted = animator.fractionComplete
//        }
//    }
//
//    func updateInteractiveTransition(fractionCompleted:CGFloat) {
//        for animator in runningAnimations {
//            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
//        }
//    }
//
//    func continueInteractiveTransition (){
//        for animator in runningAnimations {
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//        }
//    }


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

