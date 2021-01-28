//
//  BerhasilViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 12/01/21.
//

import UIKit


class BerhasilViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var berhasilLabel: UILabel!
    @IBOutlet weak var siapBtn: UIButton!
    @IBOutlet var berhasilView: UIView!
    @IBAction func onSiap(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissBerhasilVC"), object: nil)
//        move(name: "NasabahMain", identifier: "NasabahMain")
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.berhasilView.center.y -= self.berhasilView.frame.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
print("viewdidload")
        berhasilLabel.text = "Kamu berhasil menabung Rp \(appDelegate.TotalHarga) hari ini."
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("asdf")
    }
}
