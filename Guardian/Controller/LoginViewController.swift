//
//  LoginViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 06/01/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTF: FloatingLabel!
    @IBOutlet weak var passwordTF: FloatingLabel!
    
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
    
    @IBAction func masukBtn(_ sender: Any) {
        
        API().login()
        
    }
}


