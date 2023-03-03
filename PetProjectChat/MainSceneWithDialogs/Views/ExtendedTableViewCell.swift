//
//  extendedTableViewCell.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 1.03.23.
//

import UIKit

class ExtendedTableViewCell: UITableViewCell {

    static let cellIdentifier = "CustomCell"
    
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
    
    let userLastMessageView = UserLastMessageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user:UserProtocol){
        userpicImageView.image = user.userpic
        userLastMessageView.nameAndLastnameLabel.text = user.name
        userLastMessageView.lastMessageLabel.text = user.lastMessage
        userLastMessageView.dateLabel.text = user.lastMessageDate
        
    }
    
    
    
    
    private func setupUI() {
        self.contentView.addSubview(userpicImageView)
        self.contentView.addSubview(userLastMessageView)
        userpicImageView.translatesAutoresizingMaskIntoConstraints = false
        userLastMessageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userpicImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            userpicImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            userpicImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
//            myImageView.heightAnchor.constraint(equalToConstant: 90),
            userpicImageView.widthAnchor.constraint(equalToConstant: 80),
            
            userLastMessageView.leadingAnchor.constraint(equalTo: userpicImageView.trailingAnchor, constant: 16),
            userLastMessageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            userLastMessageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            userLastMessageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
        
    }

}
