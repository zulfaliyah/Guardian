//
//  Admin-main.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 09/01/21.
//

import UIKit

class AdminMain: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        API().checkToken()
    }
}
