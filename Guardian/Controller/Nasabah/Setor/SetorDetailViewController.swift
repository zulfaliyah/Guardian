//
//  SetorDetailViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 11/01/21.
//

import UIKit

class SetorDetailViewController: UIViewController {
    @IBOutlet weak var viewName: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 0.5) {
            self.viewName.center.y -= self.viewName.frame.height
        }
        // Do any additional setup after loading the view.
    }
    

}
