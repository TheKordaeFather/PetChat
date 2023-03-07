//
//  CustomisedNavigationTitleView.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 3.03.23.
//

import UIKit

class CustomisedNavigationTitleView: UIView {

    init(userName:String, userDescription:String, userpic:UIImage){
        super.init(frame: .zero)
               
        self.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
        self.layer.borderWidth = 0
        
        let contactImageView = createContactImageView(userpic)
        self.addSubview(contactImageView)
        
        let userNameLabel = createUserNameLabel(userName)
        self.addSubview(userNameLabel)
        
        let descriptionLabel = createUserDescriptionLabel(userDescription)
        self.addSubview(descriptionLabel)
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createContactImageView(_ userpic:UIImage) -> UIImageView {
        let iv = UIImageView()
        iv.image = userpic
        iv.frame = CGRect(x: 5, y: 0, width: 40, height: 40)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = iv.frame.width / 2
        return iv
    }
    
    func createUserNameLabel(_ userName:String) -> UILabel {
        let label = UILabel()
        label.text = userName
        label.frame = CGRect(x: 55, y: 0, width: 220, height: 20)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }
    
    func createUserDescriptionLabel(_ userDescription:String) -> UILabel {
        let label = UILabel()
        label.text = userDescription
        label.frame = CGRect(x: 55, y: 21, width: 220, height: 20)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }
}
