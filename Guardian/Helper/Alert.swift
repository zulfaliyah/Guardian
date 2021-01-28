//
//  Alert.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 10/01/21.
//

import UIKit


class alert:UIViewController{
    
}
extension UIViewController {
    
    func alertHomeNasabah(message: String, title: String) {
      let alertController = UIAlertController(title: "Tshdf", message: "sdfgkjf", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            self.move(name: "NasabahMain", identifier: "NasabahMain")
        }))
      DispatchQueue.main.async {
          self.topmostController()?.present(alertController, animated: true, completion: nil)
      }
      
    }
    
    func alertHomeAdmin(message: String, title: String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            //self.move(name: "AdminMain", identifier: "AdminMain")
            self.performSegue(withIdentifier: "unwindFromSetujui", sender: self)
        }))
      DispatchQueue.main.async {
          self.topmostController()?.present(alertController, animated: true, completion: nil)
      }
    }
    
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    DispatchQueue.main.async {
        self.topmostController()?.present(alertController, animated: true, completion: nil)
    }
    
  }
    
   
    
    func alertLogout(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            API().logout()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            alertController .dismiss(animated: true, completion: nil)
        }))
        DispatchQueue.main.async {
            self.topmostController()?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func topmostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topController?.presentedViewController {
                topController = presentedViewController
            }
            return topController
    }
}
