//
//  QRViewController.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//
import Foundation
import UIKit
import CoreData
import CoreImage
import WhatsNewKit
class QRViewController: UIViewController {
    let titleLabel = UILabel()
    var QRimageView = UIImageView(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
    let infoLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
//            view.backgroundColor = UIColor.systemBackground
            view.backgroundColor = UIColor.black
        } else {
            // Fallback on earlier versions
            view.backgroundColor = UIColor.black
        }
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updateQR), name: Notification.Name("updateQR"), object: nil)
        titleLabel.text = "Adid"
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(10.0), range: NSRange(location: 0, length: attributedString.length))
        titleLabel.attributedText = attributedString
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.clipsToBounds = true
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 38.0, weight: .heavy)
        view.addSubview(titleLabel)
        infoLabel.frame = CGRect(x: (UIScreen.main.bounds.width / 2), y: ((UIScreen.main.bounds.height / 2) + (QRimageView.bounds.height / 1.5)), width: QRimageView.bounds.width, height: 100)
        infoLabel.textColor = UIColor.lightGray
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        infoLabel.sizeToFit()
        infoLabel.text = "scan me\nwith your phone's camera app"
        infoLabel.clipsToBounds = true
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
        QRimageView.translatesAutoresizingMaskIntoConstraints = false
        QRimageView.image = UIImage(ciImage: CreateQR())
        QRimageView.contentMode = .scaleAspectFill
        QRimageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(QRimageView)
        self.QRimageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        self.infoLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        NSLayoutConstraint.activate([
            QRimageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            QRimageView.heightAnchor.constraint(equalTo: QRimageView.widthAnchor),
            QRimageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            QRimageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: (self.view.bounds.width * 0.1)),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: ((self.view.bounds.width * 0.15))),
            infoLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            infoLabel.widthAnchor.constraint(equalTo: QRimageView.widthAnchor),
            infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: QRimageView.topAnchor, constant: ((self.view.bounds.width * 0.8) + 10)),
            ])
    }
    @objc func updateQR(){
        QRimageView.image = UIImage(ciImage: CreateQR())
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1, animations: {
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.QRimageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.infoLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        })
        whatsNewIfNeeded()
            }
        func whatsNewIfNeeded(){
                let items = [
                    WhatsNew.Item(
                        title: "Major UI Re-design",
                        subtitle: "Depth and Gestures. The menus, in fact all interactive views, have been optimised to provide a more realistic user experience. Improved gestures & animations work hand-in-hand to deliver a higher quality way to use the app.",
                        image: UIImage(named: "logo-white")),
                    WhatsNew.Item(
                        title: "New Features",
                        subtitle: "Now you can add your website and you can give your Connect-Code more are on the way! If in case you ever feel lost, the App intro is now available under the ´help´ section.",
                        image: UIImage(named: "features")),
                    WhatsNew.Item(
                        title: "Bug Fixes & Hyper-speed",
                        subtitle: "Now there is diacritics/accents support, some UI fixes and we have been working hard to get ´Adid´ to reach light-speeds",
                        image: UIImage(named: "flash")),
                    ]
                let detailButton = WhatsNewViewController.DetailButton(
                    title: "Read more",
                    action: .website(url: "https://adid.apovlabs.com")
                )
                let theme = WhatsNewViewController.Theme { configuration in
                    configuration.apply(animation: .fade)
                    configuration.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
//                    configuration.itemsView.layout = .centered
                    configuration.titleView.titleColor = UIColor.white
                    configuration.itemsView.titleColor = UIColor.white
                    configuration.itemsView.subtitleColor = UIColor.lightText
                    configuration.completionButton.backgroundColor = UIColor(red: 72/255, green: 72/255, blue: 74/255, alpha: 1)
                    configuration.completionButton.hapticFeedback = .impact(.medium)
                    configuration.detailButton = detailButton
                    configuration.itemsView.imageSize = .fixed(height: 25)
            }
                let config = WhatsNewViewController.Configuration(theme: theme)
                let version = WhatsNew.Version.current()
                let keyValueVersionStore = KeyValueWhatsNewVersionStore(keyValueable: UserDefaults.standard)
                let whatsNew = WhatsNew(version: version,title: "Major Update Ahead!", items: items)
                let whatsNewVC: WhatsNewViewController? = WhatsNewViewController(
                    whatsNew: whatsNew,
                    configuration: config,
                    versionStore: keyValueVersionStore
                )
                if let vc = whatsNewVC {
                    self.present(vc, animated: true, completion: nil)
                }
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
}
extension CIImage {
    /// Combines the current image with the given image centered.
    func combined(with image: CIImage) -> CIImage? {
        guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
        let centerTransform = CGAffineTransform(translationX: extent.midX - (image.extent.size.width / 2), y: extent.midY - (image.extent.size.height / 2))
        combinedFilter.setValue(image.transformed(by: centerTransform), forKey: "inputImage")
        combinedFilter.setValue(self, forKey: "inputBackgroundImage")
        return combinedFilter.outputImage!
    }
}
extension String {
    /// Creates a QR code for the current URL in the given color.
    func qrImage(using color: UIColor, logo: UIImage? = nil) -> CIImage? {
        let tintedQRImage = qrImage?.tinted(using: color)
        guard let logo = logo?.cgImage else {
            return tintedQRImage
        }
        return tintedQRImage?.combined(with: CIImage(cgImage: logo))
    }
    var qrImage: CIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let qrData = data(using: String.Encoding.utf8)
        qrFilter.setValue(qrData, forKey: "inputMessage")
        let qrTransform = CGAffineTransform(scaleX: 10, y: 10)
        return qrFilter.outputImage?.transformed(by: qrTransform)
    }
}
