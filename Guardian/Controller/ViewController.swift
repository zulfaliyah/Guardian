//
//  ViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 05/01/21.
//

import UIKit

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        checkFirstTimeUser()
    }
    
    func checkFirstTimeUser() {
        if(!appDelegate.hasAlreadyLaunched){
            appDelegate.sethasAlreadyLaunched()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let onboardingViewController = storyBoard.instantiateViewController(withIdentifier: "Onboarding") as! OnboardingViewController
            onboardingViewController.modalPresentationStyle = .fullScreen
            onboardingViewController.modalTransitionStyle = .crossDissolve
            self.present(onboardingViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    

}

