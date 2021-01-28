//
//  NominalViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 12/01/21.
//

import UIKit
var data : String = String()

class NominalViewController: UIViewController {
    @IBOutlet weak var seratus: UIButton!
    @IBOutlet weak var seratuslima: UIButton!
    @IBOutlet weak var duaratus: UIButton!
    @IBOutlet var nominalBtn: [UIButton]!
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var nominalTF: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func cairBtn(_ sender: Any) {
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton){
        seratus.isSelected = false
        seratuslima.isSelected = false
        duaratus.isSelected = false
        sender.isSelected = true
        data = String(sender.tag)
    }
    
    @IBAction func cairBtnAction(_ sender: Any) {
        
        if data != "" {
            API().cairkan(amount: data){
                
                (error: Error?, trxData: TrxProfile?) in
                    if let trxData = trxData {
                        print(data)
                        self.appDelegate.user_id = trxData.userID
                        self.appDelegate.trx_id = trxData.trxID
                        
                        let storyboard = UIStoryboard(name: "QRPencairan", bundle: nil)
                        let controller = (storyboard.instantiateViewController(withIdentifier: "QRPencairan")) as! QRPencairan
                        print("pindah")
                        self.navigationController?.pushViewController(controller, animated: true)
                }
            
            }
        }else {
                API().cairkan(amount: nominalTF.text ?? ""){
                    
                    (error: Error?, trxData: TrxProfile?) in
                        if let trxData = trxData {
                            print(self.nominalTF.text)
                            self.appDelegate.user_id = trxData.userID
                            self.appDelegate.trx_id = trxData.trxID
                            
                            let storyboard = UIStoryboard(name: "QRPencairan", bundle: nil)
                            let controller = (storyboard.instantiateViewController(withIdentifier: "QRPencairan")) as! QRPencairan
                            print("pindah")
                            self.navigationController?.pushViewController(controller, animated: true)
                    }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        saldo()
        shadow(view: saldoView)
        shadow(view: nominalView)
        
    }

    @IBOutlet weak var saldoView: UIView!
    @IBOutlet weak var nominalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardOnTapAround()
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "Hijau");
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(named: "Hijau")]
        
    }
    
    func hideKeyboardOnTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    private func saldo() {
        API().profil{(error: Error?, nasabahProfileData: NasabahProfile?) in
            if let nasabahProfileData = nasabahProfileData {
                self.saldoLabel.text = "Rp " + nasabahProfileData.saldo
            }
        }
    }
}

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension NominalViewController {
    func shadow(view:UIView){
        
        let view:UIView? = view
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view?.layer.shadowRadius = 10
        view?.layer.shadowOpacity = 0.1
    }
}

