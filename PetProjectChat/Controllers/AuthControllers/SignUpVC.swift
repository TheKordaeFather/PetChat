//
//  SignUpWithGoogleControllerViewController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 26.02.23.
//

import UIKit

class SignUpVC: UIViewController {
    let headerView:HeaderView = {
       let view = HeaderView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemCyan
        view.titleLabel.text = "Sign up"        
        return view
    }()
    
    let loginTextField = CustomTextField(type: .login)
    let emailTextField = CustomTextField(type: .email)
    let passwordTextField = CustomTextField(type: .password)
    let acceptButton = CustomButton(buttonSize: .big, title: "Accept")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
       

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        view.addSubview(loginTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(acceptButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            loginTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            loginTextField.heightAnchor.constraint(equalToConstant: 55),
            
            emailTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            acceptButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            acceptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            acceptButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.85),
            acceptButton.heightAnchor.constraint(equalToConstant: 55),
            
            
            
        ])
    }


}
