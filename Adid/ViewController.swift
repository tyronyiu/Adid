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
    @IBOutlet weak var qrImageView: UIImageView!
    @IBAction func editButton(_ sender: Any) {
        pushView(VC:self, name: "Main", identifier: "inputView")
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        qrImageView.alpha = 0.0
        qrImageView.image = createQR(inputString: "\(makeVCARDRequest())")
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
