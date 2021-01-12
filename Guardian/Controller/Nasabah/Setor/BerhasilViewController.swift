//
//  BerhasilViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 12/01/21.
//

import UIKit

class BerhasilViewController: UIViewController {

    @IBOutlet weak var siapBtn: UIButton!
    @IBOutlet var berhasilView: UIView!
    @IBAction func onSiap(_ sender: Any) {
        move(name: "NasabahMain", identifier: "NasabahMain")
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.berhasilView.center.y -= self.berhasilView.frame.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
