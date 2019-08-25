//
//  makeRequest.swift
//  Adid
//
//  Created by Ty Yiu on 25.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func makeVCARDRequest() -> String{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
    //request.predicate = NSPredicate(format: "age = %@", "12")
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        var VCardString = "BEGIN:VCARD\n"+"VERSION:3.0\n"
        for data in result as! [NSManagedObject] {
            
            if data.value(forKey: "firstname") as! String !=  "" {
                let firstname = data.value(forKey: "firstname" )
                VCardString = VCardString + "FN:\(firstname!)"
            }
            if data.value(forKey: "lastname") as! String !=  "" {
                let lastname = data.value(forKey: "lastname" )
                VCardString = VCardString + " \(lastname!)\n"
                VCardString = VCardString + "N:\(lastname!);"
                if data.value(forKey: "firstname") as! String !=  "" {
                    let firstname = data.value(forKey: "firstname" )
                    VCardString = VCardString + "\(firstname!);;;\n"
                }
            }
            if data.value(forKey: "company") as! String !=  "" {
                let company = data.value(forKey: "company" )
                VCardString = VCardString + "ORG:\(company!)\n"
            }
            if data.value(forKey: "phone") as! String !=  "" {
                let phone = data.value(forKey: "phone" )
                VCardString = VCardString + "TEL;TYPE=CELL:\(phone!)\n"
            }
            if data.value(forKey: "email") as! String !=  "" {
                let email = data.value(forKey: "email" )
                VCardString = VCardString + "EMAIL;TYPE=Email:\(email!)\n"
            }
            if data.value(forKey: "linkedin") as! String !=  "" {
                let linkedin = data.value(forKey: "linkedin" )
                VCardString = VCardString + "X-SOCIALPROFILE;type=linkedin;x-user=\(linkedin!):http://linkedin.com/in/\(linkedin!)\n"
            }
            if data.value(forKey: "instagram") as! String !=  "" {
                let instagram = data.value(forKey: "instagram" )
                VCardString = VCardString + "X-SOCIALPROFILE;type=instagram;x-user=\(instagram!):http://instagram.com/\(instagram!)\n"
            }
            if data.value(forKey: "snapchat") as! String !=  "" {
                let snapchat = data.value(forKey: "snapchat" )
                VCardString = VCardString + "X-SOCIALPROFILE;type=snapchat;x-user=\(snapchat!):http://snapchat.com/add/\(snapchat!)\n"
            }
            VCardString = VCardString + "END:VCARD"
            return VCardString
        }
        
    } catch {
        print("Failed")
        return ""
    }
    return ""
}
