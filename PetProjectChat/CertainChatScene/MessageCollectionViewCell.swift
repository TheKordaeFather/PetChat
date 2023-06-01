//
//  MessageCollectionViewCell.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 29.05.23.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    var wrapView:UIView!
    var textLabel:UILabel!
    var profileImage:UIImageView!
    var isEmpty = true
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        wrapView.removeFromSuperview()
        
    }
    
    
    
    func editCellYou(text:String, image:UIImage, num:Int){
        wrapView = UIView()
        textLabel = UILabel()
        textLabel.text = " \(num) \(text)"
        textLabel.textAlignment = .right
        profileImage = UIImageView(image: image)
                
        wrapView.addSubview(textLabel)
        wrapView.addSubview(profileImage)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            profileImage.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 5),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.rightAnchor.constraint(equalTo: wrapView.rightAnchor, constant: -5),
            profileImage.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -5),
            
            textLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 5),
            textLabel.leftAnchor.constraint(equalTo: wrapView.leftAnchor, constant: 5),
            textLabel.rightAnchor.constraint(equalTo: profileImage.leftAnchor, constant: -10),
            textLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -5),
            
        ])
        configureCell()
    }
    
    func editCellCompanion(text:String, image:UIImage, num:Int){
        wrapView = UIView()
        textLabel = UILabel()
        textLabel.text = " \(num) \(text)"
        textLabel.textAlignment = .left
        profileImage = UIImageView(image: image)
        
        wrapView.addSubview(textLabel)
        wrapView.addSubview(profileImage)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 5),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.leftAnchor.constraint(equalTo: wrapView.leftAnchor, constant: 5),
            profileImage.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -5),
            
            textLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 5),
            textLabel.rightAnchor.constraint(equalTo: wrapView.rightAnchor, constant: -5),
            textLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10),
            textLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -5),
            
            
            
        ])
        
        configureCell()
        
    }
   
    
    
    
    func configureCell(){
        isEmpty = false
        self.addSubview(wrapView)
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            wrapView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
    
}
