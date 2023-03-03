//
//  HeaderView.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 24.02.23.
//

import UIKit

class HeaderView: UIView {

     var logoImageView = UIImageView()
     var titleLabel = UILabel()
    
    init(){
        super.init(frame: .zero)
        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "logo")
        
        titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.text = "Talky"
                
    }
    
    
    private func setupUI() {
        self.backgroundColor = .systemCyan
        
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([//
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                        
            
        ])
         
    }
    
    
    
}
