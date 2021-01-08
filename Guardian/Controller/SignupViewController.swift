//
//  SignupViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 07/01/21.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTapAround()
    }
    
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
        
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}
