//
//  QRPencairan.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 16/01/21.
//

import UIKit
import CoreImage



class QRPencairan: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var imgQRImage: UIImageView!

    let Hijau = UIColor(red: 0.33, green: 0.48, blue: 0.53, alpha: 1.00)
    
    @IBAction func simpanBtn(_ sender: Any) {
        UIGraphicsBeginImageContext(imgQRImage.frame.size)
        imgQRImage.layer.render(in: UIGraphicsGetCurrentContext()!)
            let output = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
                UIImageWriteToSavedPhotosAlbum(output!, nil, nil, nil)
                let alert = UIAlertController(title: "QR Tersimpan", message: "Bukti pencairan telah disimpan di dalam galeri", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToATapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToA", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userId = appDelegate.user_id
        let trxId = appDelegate.trx_id
        print(String(userId))
        let string = String(trxId) + "-" + String(userId)
        guard let qrURLImage = URL(string: string)?.qrImage(using: self.Hijau)else{return}
            self.imgQRImage.image = UIImage(ciImage: qrURLImage)
    }

}

extension URL {

    /// Creates a QR code for the current URL in the given color.
    func qrImage(using color: UIColor, logo: UIImage? = nil) -> CIImage? {
        let tintedQRImage = qrImage?.tinted(using: color)
        guard let logo = logo?.cgImage else {
            return tintedQRImage
        }
        return tintedQRImage?.combined(with: CIImage(cgImage: logo))
    }

    /// Returns a black and white QR code for this URL.
    var qrImage: CIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let qrData = absoluteString.data(using: String.Encoding.ascii)
        qrFilter.setValue(qrData, forKey: "inputMessage")
        let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
        return qrFilter.outputImage?.transformed(by: qrTransform)
    }
}

extension CIImage {

    /// Inverts the colors and creates a transparent image by converting the mask to alpha.
    /// Input image should be black and white.
    var transparent: CIImage? {
        return inverted?.blackTransparent
    }

    /// Inverts the colors.
    var inverted: CIImage? {
        guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else { return nil }
        invertedColorFilter.setValue(self, forKey: "inputImage")
        return invertedColorFilter.outputImage
    }

    /// Converts all black to transparent.
    var blackTransparent: CIImage? {
        guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        blackTransparentFilter.setValue(self, forKey: "inputImage")
        return blackTransparentFilter.outputImage
    }

    /// Applies the given color as a tint color.
    func tinted(using color: UIColor) -> CIImage?
    {
        guard
            let transparentQRImage = transparent,
            let filter = CIFilter(name: "CIMultiplyCompositing"),
            let colorFilter = CIFilter(name: "CIConstantColorGenerator") else { return nil }

        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)
        return filter.outputImage!
    }

    /// Combines the current image with the given image centered.
    func combined(with image: CIImage) -> CIImage? {
        guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
        let centerTransform = CGAffineTransform(translationX: extent.midX - (image.extent.size.width / 2), y: extent.midY - (image.extent.size.height / 2))
        combinedFilter.setValue(image.transformed(by: centerTransform), forKey: "inputImage")
        combinedFilter.setValue(self, forKey: "inputBackgroundImage")
        return combinedFilter.outputImage!
    }
}
