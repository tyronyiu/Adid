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
}
