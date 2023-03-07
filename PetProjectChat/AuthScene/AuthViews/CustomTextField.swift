//
//  CustomTextField.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 24.02.23.
//

import UIKit

class CustomTextField: UITextField {
                
    enum TextFieldType:String {
        case email = "email"
        case login = "login"
        case password = "password"
    }
    
    var textFieldType:TextFieldType
    
    init(type:TextFieldType){
        textFieldType = type
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        self.returnKeyType = .done
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch type {
        case .email:
            self.placeholder = "email"
            self.keyboardType = .emailAddress
        case .login:
            self.placeholder = "login"
        case .password:
            self.placeholder = "password"
//            self.isSecureTextEntry = true
//            self.textContentType = .password
        }
        
        
                
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
