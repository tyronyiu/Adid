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
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
    //request.predicate = NSPredicate(format: "age = %@", "12")
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            if data.value(forKey: Tag) != nil {
                //                print(data.value(forKey: Tag))
                return data.value(forKey: Tag) as! String
            }
            else {return ""}
        }
    } catch {
        print("Failed")
        return ""
    }
    return ""
}

