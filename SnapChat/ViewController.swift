//
//  ViewController.swift
//  SnapChat
//
//  Created by Xiaohao Li on 2017/5/15.
//  Copyright © 2017年 Xiaohao Li. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Snapchat"
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
        
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.text = "dannyli0109@gmail.com"
        return tf
        
    }()
    
    let passwordTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.text = "1993192003"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let turnUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Turn Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor.orange
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(handleTurnUp), for: .touchUpInside)
        return btn
    }()
    
    
    func handleTurnUp() {
        guard let email = emailTextField.text, email.characters.count > 0 else { return }
        guard let password = passwordTextfield.text, password.characters.count > 0 else { return }
        turnUpButton.isEnabled = false
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in

            
            if let err = err {
                print("error: \(err)")
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, err) in
                    
                    
                    if let err = err {
                        print("error on creating user: \(err)")
                        return
                    }
                    
                    print("User created successfully")
                    self.presentMainVC()
                    
                })
            } else {
                print("Log in successfully")
                self.presentMainVC()

            }
            
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let user = FIRAuth.auth()?.currentUser {
//            presentMainVC()
//        }
        
        
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupStackView()
    }
    
  
    
    func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextfield, turnUpButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.anchor(top: titleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 0)
        
    }
    
    func presentMainVC() {
        let mainVC = SnapListTableViewController()
        let navVC = UINavigationController(rootViewController: mainVC)
        self.present(navVC, animated: true, completion: nil)
    }
    
    
}

