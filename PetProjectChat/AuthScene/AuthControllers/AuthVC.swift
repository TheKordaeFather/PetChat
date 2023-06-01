//
//  LoginController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 24.02.23.
//

import UIKit

class AuthVC: UIViewController {
    
    let headerView = HeaderView()
    
    let adminButton = CustomButton(buttonSize: .small, title: "adminEnter")
    let registrationButton = CustomButton(buttonSize: .small, title: "Registration")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.signInTextView.delegate = self
        
        registrationButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        adminButton.addTarget(self, action: #selector(didTapAdminButton), for: .touchUpInside)
       
        
    }
    
    let orLabel:UILabel = {
        let label = UILabel()
        label.text = "──────        or        ──────"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    let signInTextView:UITextView = {
        let tv = UITextView()
        
        let mainText = "Already have an account Sign in here"
        let linkText = "Sign in here"
        let range = (mainText as NSString).range(of: linkText)
        print(range)
        let attributedString = NSMutableAttributedString(string: "Already have an account Sign in here")
        attributedString.addAttribute(.link, value: "", range: range)
        tv.attributedText = attributedString
        
        tv.textColor = .label
        tv.textAlignment = .center
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 15, weight: .light)
        tv.isSelectable = true
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        view.addSubview(adminButton)
        view.addSubview(orLabel)
        view.addSubview(registrationButton)
        view.addSubview(signInTextView)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        adminButton.translatesAutoresizingMaskIntoConstraints = false
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        signInTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            adminButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            adminButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.9),
            adminButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            adminButton.heightAnchor.constraint(equalToConstant: 55),
        
            orLabel.topAnchor.constraint(equalTo: adminButton.bottomAnchor, constant: 20),
            orLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.9),
            orLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            orLabel.heightAnchor.constraint(equalToConstant: 55),
            
            registrationButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
            registrationButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.9),
            registrationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            registrationButton.heightAnchor.constraint(equalToConstant: 55),
            
            signInTextView.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 50),
            signInTextView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.9),
            signInTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signInTextView.heightAnchor.constraint(equalToConstant: 55),
            
        ])
                
         
    }
    
    @objc func didTapSignUpButton() {
        let vc = SignUpVC()
        navigationController?.pushViewController(vc, animated: false)
    }
    

    @objc func didTapAdminButton() {
        let vc = ChatsViewController()
                        
       
        ChatService.shared.getAllUsers(completion: { list in
            
            YourProfileUser.shared.friendList = list            
            AuthService.shared.getYourProfileData()
                        
            self.navigationController?.viewControllers[0] = vc
            self.navigationController?.popToRootViewController(animated: true)
            
        })
                                
        
    }
    

}


extension AuthVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        let vc = SignInVC()
        navigationController?.pushViewController(vc, animated: true)
        
        return true
    }
        
        
}
