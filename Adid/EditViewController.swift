//
//  EditViewController.swift
//  Adid
//
//  Created by Ty Yiu on 21.09.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditViewController: UIViewController {
    let titleLabel = UILabel()
    let contactButton = UIButton()
    let aboutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.black
        } else {
            view.backgroundColor = UIColor.black
        }
        
        titleLabel.text = "Edit Code"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.clipsToBounds = true
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 38.0, weight: .heavy)
        view.addSubview(titleLabel)
        
        contactButton.setTitle("Change Details", for: .normal)
        contactButton.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
        contactButton.setBackgroundColor(color: UIColor.darkGray, forState: UIControl.State.highlighted)
        contactButton.layer.cornerRadius = 5
        contactButton.layer.borderColor = UIColor.white.cgColor
        contactButton.layer.borderWidth = 1.5
        contactButton.setTitleColor(.white, for: .normal)
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.clipsToBounds = true
        contactButton.titleLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .heavy)
        contactButton.addTarget(self, action: #selector(contactButtonAction), for: .touchUpInside)
        view.addSubview(contactButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.bounds.width * 0.15)),
            titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: (self.view.bounds.width * 0.05)),
            

            contactButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            contactButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            contactButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            contactButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            

            ])
    }
    
    @objc func contactButtonAction(sender: UIButton!) {
        let vc = InputViewController()
        self.present(vc, animated: true, completion: nil)
    }
    

}
