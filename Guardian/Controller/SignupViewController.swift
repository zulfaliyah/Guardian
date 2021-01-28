//
//  SignupViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 07/01/21.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameTF: FloatingLabel!
    @IBOutlet weak var passwordTF: FloatingLabel!
    @IBOutlet weak var namaTF: FloatingLabel!
    @IBOutlet weak var nomorTF: FloatingLabel!
    
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

    @IBAction func daftarBtn(_ sender: Any) {
        API().daftar(fullname: namaTF.text ?? "", username: usernameTF.text ?? "", password: passwordTF.text ?? "", phone: nomorTF.text ?? "")
    }
}
