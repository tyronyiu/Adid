//
//  welcomeViewController.swift
//  Connect
//
//  Created by Ty Yiu on 08.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import UIKit

class welcomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.text = "Enter your desired contact details to be included in your Adid ConnectCode."
        nextButton.layer.cornerRadius = 6
        nextButton.clipsToBounds = true
        self.nextButton.alpha = 0.0
        self.welcomeLabel.alpha = 0.0
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1, animations: {
            self.welcomeLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.nextButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.nextButton.alpha = 1.0
                self.welcomeLabel.alpha = 1.0
                self.nextButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.welcomeLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                //                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    
}
