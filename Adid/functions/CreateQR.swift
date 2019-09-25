//
//  createQR.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit

func CreateQR() -> CIImage {
    let qrcolor = UIColor(red:255/255, green:255/255, blue:255/255, alpha:1.0)
    let qrLogo = resizeImage(image: UIImage(named: "logo")!, targetSize: CGSize(width: 200.0, height: 200.0))
    let transparentImage = qrLogo.image(alpha: 0.95)
    let qrURLImage = String(string: makeVCARDRequest())?.qrImage(using: qrcolor, logo: transparentImage)
    return qrURLImage!
    }
extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
