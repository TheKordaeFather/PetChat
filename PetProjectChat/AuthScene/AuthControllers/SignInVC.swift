//
//  EnterLoginAndPasswordController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 26.02.23.
//

import UIKit

class SignInVC: UIViewController {

    let headerView:HeaderView = {
       let view = HeaderView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemCyan
        view.titleLabel.text = "Sign in" 
        return view
    }()
    
    var loginOrEmailLabel = UILabel()
    var passwordLabel = UILabel()
    
    let loginTextField = CustomTextField(type: .login)
    let passwordTextField = CustomTextField(type: .password)
    let signInButton = CustomButton(buttonSize: .big, title: "Sign in")
               
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        
        loginOrEmailLabel.text = "email or nickname"
        loginOrEmailLabel.numberOfLines = 2
        
        passwordLabel.text = "password"
        
    }
       

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        view.addSubview(loginOrEmailLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        loginOrEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            loginOrEmailLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            loginOrEmailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginOrEmailLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            loginOrEmailLabel.heightAnchor.constraint(equalToConstant: 55),
            
            loginTextField.topAnchor.constraint(equalTo: loginOrEmailLabel.bottomAnchor, constant: 1),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            loginTextField.heightAnchor.constraint(equalToConstant: 55),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            passwordLabel.heightAnchor.constraint(equalToConstant: 55),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 1),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
                                    
        ])
    }
    
    @objc func didTapSignInButton(){
        
        
    }

}
