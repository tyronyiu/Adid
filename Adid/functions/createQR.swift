//
//  createQR.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit

func createQR(inputString: String) -> UIImage {
    let data = inputString.data(using: String.Encoding.ascii)
    // Get a QR CIFilter
    let qrFilter = CIFilter(name: "CIQRCodeGenerator")
    // Input the data
    qrFilter!.setValue(data, forKey: "inputMessage")
    // Get the output image
    let qrImage = qrFilter!.outputImage
    // Scale the image
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledQrImage = qrImage!.transformed(by: transform)
    // Invert the colors
    let colorInvertFilter = CIFilter(name: "CIColorInvert")
    colorInvertFilter!.setValue(scaledQrImage, forKey: "inputImage")
    let outputInvertedImage = colorInvertFilter!.outputImage
    // Replace the black with transparency
    let maskToAlphaFilter = CIFilter(name: "CIMaskToAlpha")
    maskToAlphaFilter!.setValue(outputInvertedImage, forKey: "inputImage")
    let outputCIImage = maskToAlphaFilter!.outputImage
    // Do some processing to get the UIImage
    let context = CIContext()
    let cgImage = context.createCGImage(outputCIImage!, from: outputCIImage!.extent)
    let processedImage = UIImage(cgImage: cgImage!)
    return processedImage
}
