//
//  createData.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func createData(formValues: Dictionary<String, Any>) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "UserContactDetails", in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
for entry in formValues{
    let value = entry.value
    if value == nil {
        newUser.setValue("", forKey: entry.key)
    }
    else {
        newUser.setValue(value, forKey: entry.key)
    }
}
do {
    try context.save()
    //            push main View
    
} catch {
    print("Failed saving")
}
    
}
