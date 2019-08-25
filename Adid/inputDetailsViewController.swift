//
//  inputDetailsViewController.swift
//  Connect
//
//  Created by Ty Yiu on 08.08.19.
//  Copyright © 2019 Ty Yiu. All rights reserved.
//

import UIKit
import CoreData

class inputDetailsViewController: UIViewController {
    
    @IBOutlet weak var firstNameInputField: UITextField!
    @IBOutlet weak var lastNameInputField: UITextField!
    @IBOutlet weak var companyInputField: UITextField!
    @IBOutlet weak var phoneInputField: UITextField!
    @IBOutlet weak var emailInputField: UITextField!
    @IBOutlet weak var linkedinInputField: UITextField!
    @IBOutlet weak var instagamInputField: UITextField!
    @IBOutlet weak var snapchatInputField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    
    func setupInputFields(){
        firstNameInputField.layer.borderColor = UIColor.white.cgColor
        firstNameInputField.layer.borderWidth = 1.5
        firstNameInputField.layer.cornerRadius = 6
        firstNameInputField.clipsToBounds = true
        
        firstNameInputField.tag = 0
        
        lastNameInputField.layer.borderColor = UIColor.white.cgColor
        lastNameInputField.layer.borderWidth = 1.5
        lastNameInputField.layer.cornerRadius = 6
        lastNameInputField.clipsToBounds = true
       
        lastNameInputField.tag = 1
        
        companyInputField.layer.borderColor = UIColor.white.cgColor
        companyInputField.layer.borderWidth = 1.5
        companyInputField.layer.cornerRadius = 6
        companyInputField.clipsToBounds = true
       
        companyInputField.tag = 2
        
        phoneInputField.layer.borderColor = UIColor.white.cgColor
        phoneInputField.layer.borderWidth = 1.5
        phoneInputField.layer.cornerRadius = 6
        phoneInputField.clipsToBounds = true
       
        phoneInputField.tag = 3
        
        emailInputField.layer.borderColor = UIColor.white.cgColor
        emailInputField.layer.borderWidth = 1.5
        emailInputField.layer.cornerRadius = 6
        emailInputField.clipsToBounds = true
       
        emailInputField.tag = 4
        
        linkedinInputField.layer.borderColor = UIColor.white.cgColor
        linkedinInputField.layer.borderWidth = 1.5
        linkedinInputField.layer.cornerRadius = 6
        linkedinInputField.clipsToBounds = true
       
        linkedinInputField.tag = 5
        
        instagamInputField.layer.borderColor = UIColor.white.cgColor
        instagamInputField.layer.borderWidth = 1.5
        instagamInputField.layer.cornerRadius = 6
        instagamInputField.clipsToBounds = true
       
        instagamInputField.tag = 6
        
        snapchatInputField.layer.borderColor = UIColor.white.cgColor
        snapchatInputField.layer.borderWidth = 1.5
        snapchatInputField.layer.cornerRadius = 6
        snapchatInputField.clipsToBounds = true
      
        snapchatInputField.tag = 7
    }
    
    
    @IBAction func saveContactDetails(_ sender: Any) {
        let firstname: String = firstNameInputField.text!
        let lastname: String = lastNameInputField.text!
        let company: String = companyInputField.text!
        let phone: String = phoneInputField.text!
        let email: String = emailInputField.text!
        let linkedin: String = linkedinInputField.text!
        let instagram: String = instagamInputField.text!
        let snapchat: String = snapchatInputField.text!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserContactDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(firstname, forKey: "firstname")
        newUser.setValue(lastname, forKey: "lastname")
        newUser.setValue(company, forKey: "company")
        newUser.setValue(phone, forKey: "phone")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(linkedin, forKey: "linkedin")
        newUser.setValue(instagram, forKey: "instagram")
        newUser.setValue(snapchat, forKey: "snapchat")
        do {
            try context.save()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainView") as! ViewController
            self.present(newViewController, animated: true, completion: nil)
        } catch {
            print("Failed saving")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputFields()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        
        
        
    }
    
    
    
    
}
