//
//  extendedTableViewCell.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 1.03.23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ExtendedTableViewCell: UITableViewCell {

    static let cellIdentifier = "CustomCell"
    let chatService = ChatService.shared
    
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
    
    func configure(user:UserProtocol, index:Int){
       
        userpicImageView.image = user.userpic
        userLastMessageView.nameAndLastnameLabel.text = user.email        
                        
        getUserLastMessage(otherUser: user) { [self] lastMessage in
            
            userLastMessageView.lastMessageLabel.text = lastMessage
        }
        
        userLastMessageView.dateLabel.text = user.lastMessageDate
        
    }
    
    func getUserLastMessage(otherUser:UserProtocol, completion: @escaping (String) -> ()) {
        
        let yourProfileUser = YourProfileUser.shared
        var lastMessage = "last message"
        chatService.getConversationId(otherId: otherUser.id) { convoId in
        
            let db = Firestore.firestore()
            let docRef = db.collection("conversations").document(convoId)
            docRef.getDocument { document, error in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    lastMessage = dataDescription?["lastMessage"] as! String
                    completion(lastMessage)
                } else {
                        print("Document does not exist")
                        
                }
            }
        }
        
        
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
            userpicImageView.widthAnchor.constraint(equalToConstant: 80),
            
            userLastMessageView.leadingAnchor.constraint(equalTo: userpicImageView.trailingAnchor, constant: 16),
            userLastMessageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            userLastMessageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            userLastMessageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
        
    }

}
