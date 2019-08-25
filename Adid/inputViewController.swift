//
//  inputViewController.swift
//  Adid
//
//  Created by Ty Yiu on 08.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import CoreData

let button = UIButton(frame: .zero)
let headerView = UIView()
let titleLabel = UILabel()
let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)

class inputViewController: FormViewController {
    
    
    @objc func buttonAction(sender: UIButton!) {
        DeleteAllData()
        var formValues = [String: Any]()
        formValues = form.values() as [String : Any]
        createData(formValues: formValues)
        pushView(VC: self, name: "Main", identifier: "mainView")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scrollView.contentSize = CGSize(width: view.frame.width, height: 2 * scrollView.frame.height)
       
//        self.tableView.frame.size.height = self.tableView.contentSize.height
//        self.tableView.isScrollEnabled = false
        self.tableView?.frame = CGRect(x: ((self.tableView?.frame.origin.y)! + ((self.tableView?.frame.size.width)! * 0.05)), y: -100, width: (UIScreen.main.bounds.size.width * 0.9), height: ((self.tableView?.frame.size.height)! * 1))
        
        tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        self.tableView.alpha = 0.0
        self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = UIColor.black
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        // Enables smooth scrolling on navigation to off-screen rows
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 20
//        view.addSubview(self.tableView)
        
        titleLabel.frame = CGRect(x: 20, y: 0, width: headerView.bounds.width, height: (headerView.bounds.height))
        titleLabel.text = "Contact Details"
        titleLabel.alpha = 0.0
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 38.0, weight: .heavy)
        titleLabel.backgroundColor = UIColor.black
        headerView.addSubview(titleLabel)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubview(headerView)
        
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
        
        
        
        
        view.backgroundColor = UIColor.black
        
//         let cellSpacingHeight: CGFloat = 50
//        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return cellSpacingHeight
//        }
        
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
//        let button = UIButton(frame: CGRect(x: ((UIScreen.main.bounds.width / 2) - (250/2)), y: (770 - 72), width: 250, height: 72))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.black)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        view.addSubview(button)
        button.alpha = 0.0
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 72),
//            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150)
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1),
            ])
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.tableView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                button.alpha = 1.0
                titleLabel.alpha = 1.0
                self.tableView.alpha = 1.0
                button.transform = CGAffineTransform(scaleX: 1, y: 1)
                titleLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.tableView.transform = CGAffineTransform(scaleX: 1, y: 1)
//                button.transform = CGAffineTransform.identity
            }
        })
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 10), 150)
        
//        var height = headerView.bounds.height
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
//        headerView.alpha = headerView.alpha - 0.01
        
        self.tableView?.frame = CGRect(x: ((self.tableView?.frame.origin.y)! + ((self.tableView?.frame.size.width)! * 0.05)), y: 0, width: (UIScreen.main.bounds.size.width * 0.9), height: ((self.tableView?.frame.size.height)! * 1))
        tableView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 100, right: 0)
//        descLabel.alpha = 0.0
    }
   
}
