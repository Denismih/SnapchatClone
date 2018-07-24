//
//  LoginViewController.swift
//  SnapchatClone
//
//  Created by Admin on 24.07.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import AlertBar

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var topBTN: UIButton!
    @IBOutlet weak var botomBTN: UIButton!
    @IBOutlet weak var newLbl: UILabel!
    
    var signUpMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func topBtnTapped(_ sender: Any) {
        if let email = email.text {
            if let password = password.text {
                if signUpMode {
                    //Sign Up
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                           AlertBar.show(type: .error, message: error.localizedDescription, duration: 20)
                        } else {
                            AlertBar.show(type: .success, message: "Sign Up was succesful!", duration: 10)
                        }
                    }
                } else {
                    //Log In
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            AlertBar.show(type: .error, message: error.localizedDescription, duration: 20)
                        } else {
                            AlertBar.show(type: .success, message: "Log In was succesful!", duration: 10)
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func botomBtnTapped(_ sender: Any) {
        if signUpMode {
            //switch to login
            signUpMode = false
            topBTN.setTitle("Log In", for: .normal)
            botomBTN.setTitle("Register", for: .normal)
            newLbl.text = "New on snapchat?"
        } else {
            //switch to signup
            signUpMode = true
            topBTN.setTitle("Register", for: .normal)
            botomBTN.setTitle("Log in", for: .normal)
            newLbl.text = "Already have an account?"
        }
    }
    
}

