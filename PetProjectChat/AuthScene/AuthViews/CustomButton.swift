//
//  CustomButton.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 25.02.23.
//

import UIKit

class CustomButton: UIButton {

    enum ButtonType {
        case small
        case medium
        case big
    }
        
    
    init(buttonSize:ButtonType, title:String){
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemCyan
        
        switch buttonSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .medium:
            self.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
