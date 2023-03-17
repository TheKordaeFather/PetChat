//
//  UserLastMessageView.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 1.03.23.
//

import UIKit

class UserLastMessageView: UIView {

    let nameAndLastnameLabel:UILabel = {
        let label = UILabel()
        label.text = "Андрей Кордюков"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "28.02.2022"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let lastMessageLabel:UILabel = {
        let label = UILabel()
        label.text = "Привет как дела, го вечером в доту"        
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.addSubview(nameAndLastnameLabel)
        self.addSubview(dateLabel)
        self.addSubview(lastMessageLabel)
        
        nameAndLastnameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            nameAndLastnameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            nameAndLastnameLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            nameAndLastnameLabel.heightAnchor.constraint(equalToConstant: 35),
            nameAndLastnameLabel.widthAnchor.constraint(equalToConstant: 200),
            
            dateLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: nameAndLastnameLabel.trailingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
                        
            lastMessageLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            lastMessageLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            lastMessageLabel.heightAnchor.constraint(equalToConstant: 35),
            lastMessageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
        
        
    }

}
