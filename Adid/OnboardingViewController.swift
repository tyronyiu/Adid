//
//  onboarding.swift
//  Adid
//
//  Created by Ty Yiu on 21.09.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//
import UIKit
import paper_onboarding

let backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
let skipButton = UIButton()
fileprivate let items = [
    OnboardingItemInfo(informationImage: UIImage(named:"logo-white")!,
    title: "The Adid Connect-Code",
    description: "Is your personal, digital business or contact card; represented in the form of a qr-code. People you want to share your details with can scan this code with their normal iPhone camera. That's it! Don't worry, you can change your details at any time!",
    pageIcon: UIImage(named:"logo-white")!,
    color: backgroundColor,
    titleColor: UIColor.white,
    descriptionColor: UIColor.lightGray,
    titleFont: UIFont.systemFont(ofSize: 20, weight: .black),
    descriptionFont: UIFont.systemFont(ofSize: 14, weight: .regular)),
    OnboardingItemInfo(informationImage: UIImage(named:"features")!,
    title: "The App",
    description: "You can intuitively swipe left and right to switch between the \"edit\", \"home\" and \"menu\" view. if you ever forget something, you can open this intro under \"help\".",
    pageIcon: UIImage(named:"features")!,
    color: backgroundColor,
    titleColor: UIColor.white,
    descriptionColor: UIColor.lightGray,
    titleFont: UIFont.systemFont(ofSize: 20, weight: .black),
    descriptionFont: UIFont.systemFont(ofSize: 14, weight: .regular)),
    OnboardingItemInfo(informationImage: UIImage(named:"flash")!,
    title: "Hyper-Speed",
    description: "Now That's All! You can go on to create your connect-code and share your details the simple, safe and superfast way!",
    pageIcon: UIImage(named:"flash")!,
    color: backgroundColor,
    titleColor: UIColor.white,
    descriptionColor: UIColor.lightGray,
    titleFont: UIFont.systemFont(ofSize: 20, weight: .black),
    descriptionFont: UIFont.systemFont(ofSize: 14, weight: .regular))
   ]
class OnboardingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        onboarding.clipsToBounds = true
        view.addSubview(onboarding)
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
        let constraint = NSLayoutConstraint(item: onboarding, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        }
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.tag = 1
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        skipButton.setTitle("skip", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.clipsToBounds = true
        skipButton.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        skipButton.setTitleColor(.gray, for: .highlighted)
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            skipButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            skipButton.widthAnchor.constraint(equalToConstant: 50),
                    ])
    }
    
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")

    @objc func skipButtonAction(sender: UIButton!) {
        if launchedBefore {
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } else {
            let vc = InputViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
   

  
    
}

extension OnboardingViewController: PaperOnboardingDelegate {

    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        item.descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        item.descriptionLabel?.clipsToBounds = true
        
        
//        NSLayoutConstraint.activate([
//            (item.descriptionLabel?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))!,
//            (item.descriptionLabel?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))!
//        ])

    }
    
    
    
}




extension OnboardingViewController: PaperOnboardingDataSource {

func onboardingItem(at index: Int) -> OnboardingItemInfo {
    return items[index]
}

func onboardingItemsCount() -> Int {
    return 3
}
}
