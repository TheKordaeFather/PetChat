//
//  SignUpWithGoogleControllerViewController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 26.02.23.
//

import UIKit

class SignUpVC: UIViewController {
    
    var endEditingTap:UITapGestureRecognizer?//скрыть клавиатуру п онажатию
    var checkField = CheckField.shared
    var authService = AuthService.shared
    
    
    
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
        
        acceptButton.addTarget(self, action: #selector(acceptButtonDidTapped), for: .touchUpInside)
        
        endEditingTap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(endEditingTap!)
        
        
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
    
    @objc func acceptButtonDidTapped(){
        
        unionValid()
        
        let login = loginTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let signUpUserEntity = SignUpEntity(login: login, email: email, password: password)
        authService.createNewUser(signUpUserEntity) { [weak self] code in
            switch code.code {
            case 0:
                print("ошибка регистрации")
            case 1:
                print("успешно зарегистрировались")
                let alert = UIAlertController(title: "congrats", message: "with registration", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "ok", style: .default) {_ in
                    self?.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okButton)
                self?.present(alert, animated: true)
                self?.authService.confirmEmail()
            default :
                print("неизвестно что произошло")
            }
        }
    }
    
    
    
    
    func unionValid(){
        guard checkField.validField(view, loginTextField) else {
            print("login is shit")
            return
        }
        print("login is correct")
        
        guard checkField.validField(view, emailTextField) else {
            print("email is shit")
            return
        }
        print("email is correct")
        
        guard checkField.validField(view, passwordTextField) else {
            print("password is shit")
            return
        }
        print("password is correct")
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
