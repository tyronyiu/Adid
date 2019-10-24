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

class InputViewController: FormViewController, UITextFieldDelegate {
    let button = UIButton(frame: .zero)
    let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height * 0.15)))
    let titleLabel = UILabel()
    let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
    var popup:UILabel!
    func showAlert() {
        popup = UILabel(frame: CGRect(x: 100, y: 200, width: .zero, height: 50))
        popup.text = "saved"
        popup.textColor = UIColor(red: CGFloat(92.0/255.0), green: CGFloat(184.0/255.0), blue: CGFloat(92.0/255.0), alpha: CGFloat(0.9))
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.clipsToBounds = true
        popup.textAlignment = .center
        self.view.addSubview(popup)
        NSLayoutConstraint.activate([
            popup.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(button.bounds.height + 40 )),
            popup.heightAnchor.constraint(equalToConstant: 50),
            popup.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }
    @objc func dismissAlert(){
        if popup != nil {
            popup.removeFromSuperview()
        }
    }
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    @objc func buttonAction(sender: UIButton!) {
        showAlert()
        DeleteAllData()
        var formValues = form.values()
        for entry in formValues{
            if entry.value == nil{
                formValues[entry.key] = ""
            }
        }
        print(formValues)
        
        createData(formValues: formValues as! Dictionary<String, String>)
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updateQR"), object: nil)
        if launchedBefore {
        button.isEnabled = false
        button.backgroundColor = UIColor.gray
        button.setTitleColor(.darkGray, for: .normal)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
            self.button.isEnabled = true
        })
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
            self.button.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.8))
        })
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
            self.button.setTitleColor(.black, for: .normal)
        })
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        notificationFeedbackGenerator.notificationOccurred(.success)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        }
        else{
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    override func inputAccessoryView(for row: BaseRow) -> UIView? {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if launchedBefore {
        self.setNavigationBar()
        }
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tableView.contentInset = UIEdgeInsets(top: (self.view.bounds.height * 0.05), left: 0, bottom: 100, right: 0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        navigationOptions = RowNavigationOptions.Enabled.union(.Enabled)
        animateScroll = true
        rowKeyboardSpacing = 20
        NameRow.defaultCellUpdate = { cell, row in
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
        }
        TextRow.defaultCellUpdate = { cell, row in
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
        }
        PhoneRow.defaultCellUpdate = { cell, row in
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
        }
        EmailRow.defaultCellUpdate = { cell, row in
            cell.textField.textColor = .white
            cell.height = ({return 50})
            cell.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
            cell.tintColor = UIColor.white
            cell.titleLabel?.textColor = UIColor.white
            cell.layer.masksToBounds = true
        }
        form
        +++ Section(header: "Personal", footer: "This section holds all your personal contact information.")
            <<< NameRow(){ row in
                row.title = "First Name"
                row.tag = "firstname" 
                row.value = makeRequest(Tag: row.tag!)
                }.cellUpdate({ (cell, row) in
                })
            <<< NameRow(){
                $0.title = "Last Name"
                $0.tag = "lastname"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
            <<< PhoneRow(){
                $0.title = "Phone"
                $0.tag = "phone"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
            <<< TextRow(){
                $0.title = "Email"
                $0.tag = "email"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
        +++ Section(header: "Professional", footer: "Your Organisation could be a company, a university, school or a community, you wish to share you are part of.")
            <<< TextRow(){
                $0.title = "Organisation"
                $0.tag = "company"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
            <<< TextRow(){
                $0.title = "Role"
                $0.tag = "role"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
            <<< TextRow(){
                $0.title = "Website"
                $0.tag = "workWebsite"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
            <<< TextRow(){
                $0.title = "Email"
                $0.tag = "workEmail"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
        +++ Section(header: "Social Accounts", footer: "Enter your username for the respective social account.")
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
            <<< TextRow(){
                $0.title = "Github"
                $0.tag = "github"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
        +++ Section("Other")
            <<< TextRow(){
                $0.title = "Private Website"
                $0.tag = "privateWebsite"
                $0.value = makeRequest(Tag: $0.tag!)
                }.cellUpdate({ (cell, row) in
                })
        self.form.delegate = self
        self.tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 72/255, green: 72/255, blue: 74/255, alpha: 1)
        button.tag = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.black)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.gray, for: .highlighted)
        button.setBackgroundColor(color: UIColor.darkGray, forState: UIControl.State.highlighted)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 72),
            ])
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      view.endEditing(true)
      textField.resignFirstResponder()
      return true
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        navBar.clipsToBounds = true
        let navItem = UINavigationItem(title: "Change Details")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(done))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
        NSLayoutConstraint.activate([
            navBar.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    @objc func done() { // remove @objc for Swift 3
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
extension UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self.bounds.contains(point) ? self : nil
    }
    func blink(enabled: Bool = true, duration: CFTimeInterval = 1.0, stopAfter: CFTimeInterval = 0.0 ) {
        enabled ? (UIView.animate(withDuration: duration, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.backgroundColor = UIColor.gray },
            completion: { [weak self] _ in self?.backgroundColor = UIColor.white })) : self.layer.removeAllAnimations()
        if !stopAfter.isEqual(to: 0.0) && enabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) { [weak self] in self?.layer.removeAllAnimations()
            }
        }
    }
}
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
