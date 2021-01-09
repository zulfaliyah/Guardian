//
//  ViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 05/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if API().keychain["token"] == "" {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Login" )
            self.present(vc, animated: true, completion: nil)
        }
    }
}

