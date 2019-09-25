//
//  makeRequest.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import CoreData
import UIKit
func makeRequest(Tag: String) -> String {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            if data.value(forKey: Tag) != nil {
                return data.value(forKey: Tag) as! String
            }
            else {
                return "A"
            }
        }
    }
    catch {
        print("Failed")
        return "B"
    }
    return ""
}
