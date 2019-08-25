//
//  ViewController.swift
//  Connect
//
//  Created by Ty Yiu on 08.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "inputView") as! inputViewController
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    
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
    
    func makeRequest(){
       
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var VCardString = "BEGIN:VCARD\n"+"VERSION:3.0\n"
            for data in result as! [NSManagedObject] {
                
                if data.value(forKey: "firstname") as! String !=  "" {
                    let firstname = data.value(forKey: "firstname" )
                    VCardString = VCardString + "FN:\(firstname!)"
                }
                if data.value(forKey: "lastname") as! String !=  "" {
                    let lastname = data.value(forKey: "lastname" )
                    VCardString = VCardString + " \(lastname!)\n"
                    VCardString = VCardString + "N:\(lastname!);"
                    if data.value(forKey: "firstname") as! String !=  "" {
                        let firstname = data.value(forKey: "firstname" )
                        VCardString = VCardString + "\(firstname!);;;\n"
                    }
                }
                if data.value(forKey: "company") as! String !=  "" {
                    let company = data.value(forKey: "company" )
                    VCardString = VCardString + "ORG:\(company!)\n"
                }
                if data.value(forKey: "phone") as! String !=  "" {
                    let phone = data.value(forKey: "phone" )
                    VCardString = VCardString + "TEL;TYPE=CELL:\(phone!)\n"
                }
                if data.value(forKey: "email") as! String !=  "" {
                    let email = data.value(forKey: "email" )
                    VCardString = VCardString + "EMAIL;TYPE=Email:\(email!)\n"
                }
                if data.value(forKey: "linkedin") as! String !=  "" {
                    let linkedin = data.value(forKey: "linkedin" )
                    VCardString = VCardString + "X-SOCIALPROFILE;type=linkedin;x-user=\(linkedin!):http://linkedin.com/in/\(linkedin!)\n"
                }
                if data.value(forKey: "instagram") as! String !=  "" {
                    let instagram = data.value(forKey: "instagram" )
                    VCardString = VCardString + "X-SOCIALPROFILE;type=instagram;x-user=\(instagram!):http://instagram.com/\(instagram!)\n"
                }
                if data.value(forKey: "snapchat") as! String !=  "" {
                    let snapchat = data.value(forKey: "snapchat" )
                    VCardString = VCardString + "X-SOCIALPROFILE;type=snapchat;x-user=\(snapchat!):http://snapchat.com/add/\(snapchat!)\n"
                }
                VCardString = VCardString + "END:VCARD"
                qrImageView.image = createQR(inputString: VCardString)
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        qrImageView.alpha = 0.0
        makeRequest()
//        editButton.layer.borderColor = UIColor.white.cgColor
//        editButton.layer.borderWidth = 1.5
//        editButton.layer.cornerRadius = 6
//        editButton.clipsToBounds = true
        
        
        
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1, animations: {
            self.qrImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.qrImageView.alpha = 1.0
                self.qrImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                //                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    

}

