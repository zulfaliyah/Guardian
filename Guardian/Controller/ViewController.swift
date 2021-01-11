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
        //API().checkToken()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        API().logout()
    }
}

