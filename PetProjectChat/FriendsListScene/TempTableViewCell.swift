//
//  TempTableViewCell.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 10.03.23.
//

import UIKit

class TempTableViewCell: UITableViewCell {

    static let cellIdentifier = "tempCell"
    
    let userpicImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
//        iv.contentMode = .scaleAspectFill
        iv.contentMode = .scaleToFill
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.cornerRadius = 36
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "questionmark")
        //iv.tintColor = .label
        return iv
    }()
    
    let nameAndLastnameLabel:UILabel = {
        let label = UILabel()
        label.text = "Имя фамилия"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
//
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user:UserProtocol){
        userpicImageView.image = user.userpic        
        nameAndLastnameLabel.text = user.email
    }
    
    private func setupUI() {
        self.contentView.addSubview(userpicImageView)
        self.contentView.addSubview(nameAndLastnameLabel)
        userpicImageView.translatesAutoresizingMaskIntoConstraints = false
        nameAndLastnameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userpicImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            userpicImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            userpicImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
//            myImageView.heightAnchor.constraint(equalToConstant: 90),
            userpicImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameAndLastnameLabel.leadingAnchor.constraint(equalTo: userpicImageView.trailingAnchor, constant: 16),
            nameAndLastnameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            nameAndLastnameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            nameAndLastnameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
                
    }

}
