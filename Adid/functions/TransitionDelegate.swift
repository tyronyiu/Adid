//
//  TransitionDelegate.swift
//  Adid
//
//  Created by Ty Yiu on 03.09.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//
import UIKit
class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePushAnimator()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePopAnimator()
    }
}
