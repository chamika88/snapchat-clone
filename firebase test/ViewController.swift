//
//  ViewController.swift
//  firebase test
//
//  Created by Chamikara Dharmasena on 9/18/16.
//  Copyright © 2016 Chamikara Dharmasena. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func signInTapped(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("tried signing in")
               FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                if error != nil {
                    print("cannot create a user")
                    
                } else {
                    print("created a user")
                    
                   FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)
                    
                    self.performSegue(withIdentifier: "signinsegue", sender: nil)
                }
                
               })
            
            if error != nil {
                print("we have an error\(error)")
            } else {
                print ("signed in successfully")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
                
            }
        })
    }
 

}

