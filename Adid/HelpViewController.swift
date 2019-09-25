//
//  HelpViewController.swift
//  Adid
//
//  Created by Ty Yiu on 29.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit

class HelpViewController: UIViewController {
    let titleLabel = UILabel()
    let textView = UITextView()
    var transitionDelegate: UIViewControllerTransitioningDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        titleLabel.text = "Help Section ℹ️"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.clipsToBounds = true
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 34.0, weight: .heavy)
        view.addSubview(titleLabel)
        textView.text = "LOADING... ⏰"
        textView.isEditable = false
        textView.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
        textView.layer.cornerRadius = 5
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        textView.adjustsFontForContentSizeCategory = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.clipsToBounds = true
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.bounds.height * 0.1)),
            titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.75),
            textView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.bounds.height * 0.2))
        ])
    }
    override func viewDidAppear(_ animated: Bool) {
        if let url = URL(string: "https://www.simulacron-3.com/adid/help") {
            do {
                let contents = try String(contentsOf: url)
                textView.text = contents
            } catch {
                textView.text = "You are not connected to the internet 😢"
                }
        } else {
            textView.text = "Whooops! Seems like something went wrong, please report this error!"
        }
    }
    override var prefersStatusBarHidden: Bool {
           return true
       }
    func setNavigationBar() {
            let screenSize: CGRect = UIScreen.main.bounds
            let height: CGFloat = 50
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: height))
            let navItem = UINavigationItem(title: "Help")
            let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(done))
            navItem.leftBarButtonItem = doneItem
            navBar.setItems([navItem], animated: false)
            self.view.addSubview(navBar)
     }
     @objc func done() { // remove @objc for Swift 3
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
     }
}
