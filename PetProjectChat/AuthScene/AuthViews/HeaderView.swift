//
//  HeaderView.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 24.02.23.
//

import UIKit
import AVFoundation


//MARK: custom view that contains UIImageView for logo image and a label for a title
class HeaderView: UIView {
    let widthConstraint:CGFloat = 100
    let heightConstraint:CGFloat = 100
    
     var logoImageView = UIImageView()
     var titleLabel = UILabel()
    
    init(){
        super.init(frame: .zero)
        configureUI()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        configurateSelf()
        configureLogoImageView()
        configureTitleLabel()
    }
    
    private func configureLogoImageView(){
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = widthConstraint / 2
        logoImageView.clipsToBounds = true
        logoImageView.image = UIImage(named: "logo")
        
    }
    
    private func configureTitleLabel(){
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.text = "Talky"
    }
    
    private func configurateSelf(){
        self.backgroundColor = .systemCyan
        self.layer.cornerRadius = 15
    }
    
    private func setupUI() {
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([//
            logoImageView.widthAnchor.constraint(equalToConstant: widthConstraint),
            logoImageView.heightAnchor.constraint(equalToConstant: heightConstraint),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                        
            
        ])
         
    }
    
    
    
}
