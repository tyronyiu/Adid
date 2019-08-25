//
//  deleteAllData.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func DeleteAllData(){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails"))
    do {
        try managedContext.execute(DelAllReqVar)
    }
    catch {
        print(error)
    }
}
