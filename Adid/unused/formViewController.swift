//
//  formViewController.swift
//  Adid
//
//  Created by Ty Yiu on 24.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import CoreData

class formViewController: FormViewController {
    
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
    
    
    @objc func buttonAction(sender: UIButton!) {
        
        DeleteAllData()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserContactDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        //        print("Button tapped")
        //        let row: NameRow? = form.rowBy(tag: "firstname")
        //        let value = row?.value
        //        print(value!)
        let valuesDictionary = form.values()
        //        print(valuesDictionary.keys)
        for entry in valuesDictionary{
            let value = entry.value
            if value == nil {
                newUser.setValue("", forKey: entry.key)
            }
                //            else if value as! String == "" {
                //                context.delete(value as! NSManagedObject)
                //            }
            else {
                newUser.setValue(value!, forKey: entry.key)
            }
            
            
        }
        do {
            try context.save()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainView") as! ViewController
            self.present(newViewController, animated: true, completion: nil)
        } catch {
            print("Failed saving")
        }
        
    }
    
    
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
    
    let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        // Enables smooth scrolling on navigation to off-screen rows
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 20
        
        NameRow.defaultCellUpdate = { cell, row in
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 2.5
            cell.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            
        }
        TextRow.defaultCellUpdate = { cell, row in
            
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 2.5
            
        }
        PhoneRow.defaultCellUpdate = { cell, row in
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 2.5
        }
        EmailRow.defaultCellUpdate = { cell, row in
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 2.5
        }
        
        
        
        form +++ Section("Contact Details")
            <<< NameRow(){ row in
                row.title = "First Name"
                row.tag = "firstname"
                row.value = makeRequest(Tag: row.tag!)
                print(makeRequest(Tag: row.tag!))
                }.cellUpdate({ (cell, row) in
                    
                })
            <<< NameRow(){
                $0.title = "Last Name"
                $0.tag = "lastname"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    
                })
            <<< TextRow(){
                $0.title = "Company"
                $0.tag = "company"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    
                })
            <<< PhoneRow(){
                $0.title = "Phone"
                $0.tag = "phone"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    
                })
            <<< EmailRow(){
                $0.title = "Personal Email"
                $0.tag = "email"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    
                })
            <<< EmailRow(){
                $0.title = "Work Email"
                $0.tag = "workemail"
                $0.placeholder = "PREMIUM ONLY"
                $0.placeholderColor = .darkGray
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    row.disabled = true
                    row.reload()
                })
            <<< DateInlineRow(){
                $0.title = "Birthdate"
                $0.tag = "birthdate"
                $0.value = Date()
                }.cellUpdate({ (cell, row) in
                    cell.height = ({return 50})
                    cell.backgroundColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(24.0/255.0), blue: CGFloat(24.0/255.0), alpha: CGFloat(0.8))
                    cell.tintColor = UIColor.white
                    cell.textLabel?.textColor = .white
                    cell.layer.masksToBounds = true
                    cell.layer.cornerRadius = 5
                    cell.layer.borderColor = UIColor.black.cgColor
                    cell.layer.borderWidth = 2.5
                })
            +++ Section("Adress")
            <<< TextRow(){
                $0.title = "Street Name"
                $0.tag = "streetname"
                $0.placeholder = "PREMIUM ONLY"
                $0.placeholderColor = .darkGray
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    row.disabled = true
                    row.reload()
                })
            <<< TextRow(){
                $0.title = "House/Apt. no"
                $0.tag = "houseno"
                $0.placeholder = "PREMIUM ONLY"
                $0.placeholderColor = .darkGray
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    row.disabled = true
                    row.reload()
                })
            <<< TextRow(){
                $0.title = "Post Code"
                $0.tag = "postcode"
                $0.placeholder = "PREMIUM ONLY"
                $0.placeholderColor = .darkGray
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    row.disabled = true
                    row.reload()
                })
            <<< TextRow(){
                $0.title = "City"
                $0.tag = "city"
                $0.placeholder = "PREMIUM ONLY"
                $0.placeholderColor = .darkGray
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    row.disabled = true
                    row.reload()
                })
            <<< TextRow(){
                $0.title = "Country"
                $0.tag = "country"
                $0.placeholder = "PREMIUM ONLY"
                $0.placeholderColor = .darkGray
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    row.disabled = true
                    row.reload()
                })
            +++ Section("Social Accounts")
            <<< TextRow(){
                $0.title = "LinkedIn"
                //                $0.placeholder = "This is your public profile link!"
                $0.tag = "linkedin"
                $0.value = makeRequest(Tag: $0.tag!)
                $0.placeholder = "PREMIUM ONLY"
                $0.placeholderColor = .darkGray
                }.cellUpdate({ (cell, row) in
                    row.disabled = true
                    row.reload()
                })
            <<< TextRow(){
                $0.title = "Instagram"
                $0.tag = "instagram"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    
                })
            <<< TextRow(){
                $0.title = "Snapchat"
                $0.tag = "snapchat"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                    
                })
        
        
        
        tableView.backgroundColor = UIColor.black
        view.backgroundColor = UIColor.black
        self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        let cellSpacingHeight: CGFloat = 50
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
        
        
        
        self.tableView.keyboardDismissMode = .onDrag
        
        //        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        //        tap.cancelsTouchesInView = false
        //        view.addGestureRecognizer(tap)
        
        
        
        self.tableView?.frame = CGRect(x: ((self.tableView?.frame.origin.y)! + ((self.tableView?.frame.size.width)! * 0.05)), y: 150, width: ((self.tableView?.frame.size.width)! * 0.9), height: (self.tableView?.frame.size.height)!)
        
        //        let button = UIButton(frame: CGRect(x: ((UIScreen.main.bounds.width / 2) - (250/2)), y: (770 - 72), width: 250, height: 72))
        
      
        
    }
    
 
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    
    
}


