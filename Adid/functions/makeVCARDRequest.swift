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

func makeVCARDRequest() -> String {
    let AddedText = "item1.URL;type=Added:http://adid.apovlabs.com\nitem1.X-ABLabel:Contact created via Adid\n"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContactDetails")
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        var VCardString = ""
        if !(result.isEmpty == false){
        return "X"
        }
        else {
            print(result)
        VCardString = "BEGIN:VCARD\n"+"VERSION:4.0\n"
        }
        for data in result as! [NSManagedObject] {
            
            if data.value(forKey: "firstname") !=  nil {
                if data.value(forKey: "firstname") as! String? != ""{
                    let firstname = data.value(forKey: "firstname" )
                    VCardString = VCardString + "FN:\(firstname!)\n"
            }
            }
            if data.value(forKey: "lastname") !=  nil {
                if data.value(forKey: "lastname") as! String? != ""{
                    let lastname = data.value(forKey: "lastname" )
                    VCardString = VCardString + " \(lastname!)\n"
                    VCardString = VCardString + "N:\(lastname!);"
                }
                if data.value(forKey: "firstname") !=  nil {
                    if data.value(forKey: "firstname") as! String? != ""{
                        let firstname = data.value(forKey: "firstname" )
                        VCardString = VCardString + "\(firstname!);;;\n"
                    }
                }   
            }
            if data.value(forKey: "company") !=  nil {
                if data.value(forKey: "company") as! String? != ""{
                    let company = data.value(forKey: "company" ) as! String?
                    VCardString = VCardString + "ORG:\(company!)\n"
            }
            }
            if data.value(forKey: "role") !=  nil {
                if data.value(forKey: "role") as! String? != ""{
                    let role = data.value(forKey: "role" ) as! String?
                    VCardString = VCardString + "TITLE:\(role!)\n"
            }
            }
            if data.value(forKey: "phone") !=  nil {
                if data.value(forKey: "phone") as! String? != ""{
                    let phone = data.value(forKey: "phone" )
                    VCardString = VCardString + "TEL;TYPE=CELL:\(phone!)\n"
            }
            }
            if data.value(forKey: "email") !=  nil {
                if data.value(forKey: "email") as! String? != ""{
                    let email = data.value(forKey: "email" )
                    VCardString = VCardString + "EMAIL;TYPE=PRIVATE:\(email!)\n"
            }
            }
            if data.value(forKey: "workEmail") !=  nil {
                if data.value(forKey: "workEmail") as! String? != ""{
                    let workEmail = data.value(forKey: "workEmail" )
                    VCardString = VCardString + "EMAIL;TYPE=WORK:\(workEmail!)\n"
                }
            }
            if data.value(forKey: "instagram") !=  nil {
                if data.value(forKey: "instagram") as! String? != ""{
                    let instagram = data.value(forKey: "instagram" )
                    VCardString = VCardString + "X-SOCIALPROFILE;type=instagram;x-user=\(instagram!):http://instagram.com/\(instagram!)\n"
                }
            }
            if data.value(forKey: "snapchat") !=  nil {
                if data.value(forKey: "snapchat") as! String? != ""{
                    let snapchat = data.value(forKey: "snapchat" )
                    VCardString = VCardString + "X-SOCIALPROFILE;type=snapchat;x-user=\(snapchat!):http://snapchat.com/add/\(snapchat!)\n"
                }
            }
            if data.value(forKey: "github") !=  nil {
                if data.value(forKey: "github") as! String? != ""{
                    let github = data.value(forKey: "github" )
                    VCardString = VCardString + "X-SOCIALPROFILE;type=github;x-user=\(github!):http://github.com/\(github!)\n"
                }
            }
            if data.value(forKey: "workWebsite") !=  nil {
                if data.value(forKey: "workWebsite") as! String? != ""{
                    let workWebsite = data.value(forKey: "workWebsite" ) as! String?
                    VCardString = VCardString + "URL;TYPE=work:\(workWebsite!)\n"
                }
                       }
            if data.value(forKey: "privateWebsite") !=  nil {
                if data.value(forKey: "privateWebsite") as! String? != ""{
                    let privateWebsite = data.value(forKey: "privateWebsite" ) as! String?
                    VCardString = VCardString + "URL;TYPE=private:\(privateWebsite!)\n"
                }
               
            }
            VCardString = VCardString + AddedText + "END:VCARD"
            
            return VCardString
        }
        
    }
    catch {
        print("Failed")
        return "W"
    }
    print("failed")
    return "Y"
}
