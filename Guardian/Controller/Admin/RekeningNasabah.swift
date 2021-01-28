//
//  RekeningNasabah.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 16/01/21.
//

import UIKit

class RekeningNasabah: UIViewController {
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var nomorLabel: UILabel!
    
    var cardHeight: CGFloat = 750
    var cardHandleAreaHeight: CGFloat = 550
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //setupRiwayat()
        
        setupCard()
        print("userid:" + String(appDelegate.nasabah_id))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adminData()
        
        //cardImg
        cardImg.layer.shadowColor = UIColor.black.cgColor
        cardImg.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cardImg.layer.shadowRadius = 10
        cardImg.layer.shadowOpacity = 0.1
        cardImg.layer.masksToBounds = false
        
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "Hijau");
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(named: "Hijau")]
    }
    
    private func adminData() {
        print("saldo")
        API().nasabahAdminProfil(userId: appDelegate.nasabah_id){(error: Error?, nasabahAdmData: NasabahAdmProfile?) in
            if let nasabahAdmData = nasabahAdmData {
                self.nomorLabel.text = nasabahAdmData.nomor
                self.saldoLabel.text = "Rp " + nasabahAdmData.saldo
                self.namaLabel.text = nasabahAdmData.nama
                
                print("saldo:" + nasabahAdmData.saldo)
                //print(nasabahProfileData.userID)
            }
        }
    }
    
   
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 44
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 29
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 8
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 44
    }
    
    //Riwayat
    enum CardState {
        case expanded
        case collapsed
    }

    var riwayatAdminViewController: RiwayatTransaksiAdmViewController!
    var visualEffectView: UIVisualEffectView!

    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }

    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0

    func setupResponsive() {
        let screenHeight = self.view.frame.height
        if screenHeight >= 890 { // iPhone 11 Pro Max, iPhone 11 Pro, iPhone 12 Pro Max
        } else if screenHeight >= 810 { // iPhone 12 Mini, iPhone 12 Pro, iPhone 12
            cardHandleAreaHeight = 250
        } else if screenHeight >= 730 { // iPhone 8,7,6 Plus
            cardHandleAreaHeight = 250
        } else if screenHeight >= 660 { // iPhone 8,7,6, iPhone SE 2nd Gen
            cardHeight = 550
            cardHandleAreaHeight = 220
        }
    }

    func setupCard() {
        //visualEffectView = UIVisualEffectView()
        //visualEffectView.frame = self.view.frame
        //self.view.addSubview(visualEffectView)

        riwayatAdminViewController = RiwayatTransaksiAdmViewController(nibName:"RiwayatTransaksiAdmViewController", bundle:nil)
        self.addChild(riwayatAdminViewController)
        self.view.addSubview(riwayatAdminViewController.view)

        riwayatAdminViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(NasabahMain.handleCardPan(recognizer:)))

        riwayatAdminViewController.handleArea.addGestureRecognizer(panGestureRecognizer)

        riwayatAdminViewController.view.clipsToBounds = true
    }

    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.riwayatAdminViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }

    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            // set animation
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.riwayatAdminViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.riwayatAdminViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            // when animation complete
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            // start animation
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }

    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }

    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }

    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
//    var nominalHeight: CGFloat = 509
//    var nominalHandleAreaHeight: CGFloat = 400
}
