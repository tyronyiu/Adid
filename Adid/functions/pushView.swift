//
//  pushView.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit

func pushView(VC: Any, name: String, identifier: String) {
let storyBoard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
    let newViewController = storyBoard.instantiateViewController(withIdentifier: identifier) 
    (VC as AnyObject).present(newViewController, animated: true, completion: nil)

//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as UIViewController
//    UINavigationController?.pushViewController(vc, animated: true)
//
//    // Safe Push VC
//    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as? JunctionDetailsVC {
//        if let navigator = UINavigationController {
//            navigator.pushViewController(viewController, animated: true)
//        }
//    }
}
