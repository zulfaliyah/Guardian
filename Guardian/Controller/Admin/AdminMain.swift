//
//  AdminMain.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import UIKit

class AdminMain: UIViewController {
    @IBOutlet weak var nasabahLabel: UILabel!
    @IBOutlet weak var sampahLabel: UILabel!
    @IBOutlet weak var cardImg: UIImageView!
    private let imageView = UIImageView(image: UIImage(named: "account"))
    
    var kapasitasViewController = KapasitasViewController()
    @IBOutlet weak var daftarBtn: UIView!
    @IBOutlet weak var setujuiBtn: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        title = "Dashboard"
        jumlahData()
        jumlahSampah()
        setupUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cardImg
        cardImg.layer.shadowColor = UIColor.black.cgColor
        cardImg.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cardImg.layer.shadowRadius = 10
        cardImg.layer.shadowOpacity = 0.1
        cardImg.layer.masksToBounds = false
        
        //shadow
        shadow(view: daftarBtn)
        shadow(view: setujuiBtn)
        
        //tapgestures
        daftarBtn.isUserInteractionEnabled = true
        let daftarTap = UITapGestureRecognizer(target: self, action: #selector(daftarTapped))
        daftarBtn.addGestureRecognizer(daftarTap)
        
        setujuiBtn.isUserInteractionEnabled = true
        let setujuiTap = UITapGestureRecognizer(target: self, action: #selector(setujuiTapped))
        setujuiBtn.addGestureRecognizer(setujuiTap)
        setupCard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.constraints.forEach { $0.isActive = false }
        imageView.removeFromSuperview()
    }
    
    private func jumlahData() {
        API().jumlahNasabah{(error: Error?, totalNasabahData: TotalNasabah?) in
            if let totalNasabahData = totalNasabahData {
                self.nasabahLabel.text = String(totalNasabahData.nasabah)
            }
        }
    }
    
    private func jumlahSampah() {
        API().jumlahSampah{(error: Error?, totalSampahData: TotalSampah?) in
            if let totalSampahData = totalSampahData {
                self.sampahLabel.text = String(totalSampahData.sampah)
            }
        }
    }
    
    @objc func daftarTapped(recognizer: UITapGestureRecognizer) {
        print("Image was tapped")
        imageView.alpha = 0.75
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 1.0
        }
        //alertLogout(message: "Yakin ingin keluar?", title: "Keluar")
        //API().move(name: "AdminMain", identifier: "AdminMain")
        let storyboard = UIStoryboard(name: "DaftarNasabah", bundle: nil)
        let controller = (storyboard.instantiateViewController(withIdentifier: "DaftarNasabah")) as! DaftarNasabahViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func setujuiTapped(recognizer: UITapGestureRecognizer) {
        print("Image was tapped")
        imageView.alpha = 0.75
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 1.0
        }
        
        let storyboard = UIStoryboard(name: "SetujuiScan", bundle: nil)
        let controller = (storyboard.instantiateViewController(withIdentifier: "SetujuiPencairan")) as! SetujuiPencairanViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
        //alertLogout(message: "Yakin ingin keluar?", title: "Keluar")
        //API().move(name: "AdminMain", identifier: "AdminMain")
    }
    
    @objc func imageTapped(recognizer: UITapGestureRecognizer) {
        print("Image was tapped")
        imageView.alpha = 0.75
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 1.0
        }
        alertLogout(message: "Yakin ingin keluar?", title: "Keluar")
        //API().move(name: "AdminMain", identifier: "AdminMain")
    }
    
    
    func shadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.1
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
    
    private func setupUI() {
        
        print("asd")
        navigationController?.navigationBar.prefersLargeTitles = true
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Dashboard"
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
        
        navigationBar.addSubview(imageView)

        //tap
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapRecognizer)

        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
    }
    
    //Kapasitas
    enum CardState {
        case expanded
        case collapsed
    }
    
    //var kapasitasViewController: KapasitasViewController!
    var visualEffectView: UIVisualEffectView!
    
    var cardHeight: CGFloat = 509
    var cardHandleAreaHeight: CGFloat = 330
    
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

        kapasitasViewController = KapasitasViewController(nibName:"KapasitasViewController", bundle:nil)
        self.addChild(kapasitasViewController)
        self.view.addSubview(kapasitasViewController.view)

        kapasitasViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(NasabahMain.handleCardPan(recognizer:)))

        kapasitasViewController.handleArea.addGestureRecognizer(panGestureRecognizer)

        kapasitasViewController.view.clipsToBounds = true
    }

    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.kapasitasViewController.handleArea)
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
                    self.kapasitasViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.kapasitasViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
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

//            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                case .expanded:
//                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
//                case .collapsed:
//                    self.visualEffectView.effect = nil
//                }
//            }

//            blurAnimator.startAnimation()
//            runningAnimations.append(blurAnimator)
//
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

    //nominal

    var nominalHeight: CGFloat = 509
    var nominalHandleAreaHeight: CGFloat = 400

//    func setupNominal() {
//        nominalVC = NominalViewController(nibName:"NominalViewController", bundle:nil)
//        self.view.addSubview(nominalVC.view)
//        nominalVC.view.frame = CGRect(x: 0, y: self.view.frame.height - nominalHandleAreaHeight, width: self.view.bounds.width, height: nominalHeight)
//        nominalVC.view.clipsToBounds = false
//    }
}

