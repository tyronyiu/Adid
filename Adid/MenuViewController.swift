//
//  MenuViewController.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class MenuViewController: UIViewController {
    let titleLabel = UILabel()
    let helpButton = UIButton()
    let aboutButton = UIButton()
    let transitionDelegate: UIViewControllerTransitioningDelegate = TransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
//            view.backgroundColor = UIColor.systemBackground
            view.backgroundColor = UIColor.black
        } else {
            // Fallback on earlier versions
            view.backgroundColor = UIColor.black
        }
        self.transitioningDelegate = transitionDelegate
        
        titleLabel.text = "Settings"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.clipsToBounds = true
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 38.0, weight: .heavy)
        view.addSubview(titleLabel)
        
        helpButton.setTitle("Help", for: .normal)
        helpButton.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
        helpButton.setBackgroundColor(color: UIColor.darkGray, forState: UIControl.State.highlighted)
        helpButton.layer.cornerRadius = 5
        helpButton.layer.borderColor = UIColor.white.cgColor
        helpButton.layer.borderWidth = 1.5
        helpButton.setTitleColor(.white, for: .normal)
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.clipsToBounds = true
        helpButton.titleLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .heavy)
        helpButton.addTarget(self, action: #selector(helpButtonAction), for: .touchUpInside)
        view.addSubview(helpButton)
        
        aboutButton.setTitle("About", for: .normal)
        aboutButton.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
        aboutButton.setBackgroundColor(color: UIColor.darkGray, forState: UIControl.State.highlighted)
        aboutButton.layer.cornerRadius = 5
        aboutButton.layer.borderColor = UIColor.white.cgColor
        aboutButton.layer.borderWidth = 1
        aboutButton.setTitleColor(.white, for: .normal)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        aboutButton.clipsToBounds = true
        aboutButton.titleLabel?.textColor = UIColor.white
        aboutButton.titleLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .heavy)
        aboutButton.addTarget(self, action: #selector(aboutButtonAction), for: .touchUpInside)
        view.addSubview(aboutButton)
        
  
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.bounds.width * 0.15)),
            titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: (self.view.bounds.width * 0.05)),
            
            helpButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.bounds.height * 0.3)),
            helpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            helpButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            helpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            
            aboutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.bounds.height * 0.5)),
            aboutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            aboutButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            aboutButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            
          
            
            ])
    }
    
    @objc func helpButtonAction(sender: UIButton!) {
        let vc = OnboardingViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func aboutButtonAction(sender: UIButton!) {
        let vc = AboutViewController()
        self.present(vc, animated: true, completion: nil)
    }
   
}
