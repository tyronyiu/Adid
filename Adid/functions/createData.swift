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

func createData(formValues: Dictionary<String,String>) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "UserContactDetails", in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
for entry in formValues{
    if entry.value != ""{
        newUser.setValue(entry.value, forKey: entry.key)
        let trimmedString = (entry.value as AnyObject).trimmingCharacters(in: .whitespacesAndNewlines)
        newUser.setValue(trimmedString, forKey: entry.key)
    }
    else{
        newUser.setValue("", forKey: entry.key)
    }
}
do {
    try context.save()
} catch {
    print("Failed saving")
}
    
}
