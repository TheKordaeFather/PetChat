//
//  YourProfileViewController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 17.03.23.
//

import UIKit
import Firebase
import FirebaseFirestore

class YourProfileViewController: UIViewController {
        
    var yourProfileUser = YourProfileUser.shared
    var authService = AuthService.shared
    
    let yourProfileNicknameLabel:UILabel = {
        let l = UILabel()
        l.text = "temp text"
        l.backgroundColor = .systemBackground
        l.textAlignment = .center
        return l
    }()
    
    let yourProfileImageView:UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
//        iv.layer.cornerRadius = 36
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "questionmark")
        //iv.tintColor = .label
        
        return iv
    }()
    
    let changeProfilePhotoButton:UIButton = {
        let button = UIButton()
        button.setTitle("загрузить фото", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(changeProfilePhotoDidTap), for: .touchUpInside)
        return button
    }()
    
    let nicknameTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "nickname"
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.cornerRadius = 10
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.leftViewMode = .always
        tf.keyboardType = .emailAddress
        
        return tf
    }()
    
    let acceptNicknameButton:UIButton = {
        let button = UIButton()
        button.setTitle("Принять", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemCyan
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.addTarget(self, action: #selector(acceptNicknameDidTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        yourProfileImageView.image = UIImage(named: yourProfileUser.nickName)
        yourProfileNicknameLabel.text = yourProfileUser.nickName
    }
    
    @objc func changeProfilePhotoDidTap(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func acceptNicknameDidTap(){
        yourProfileUser.nickName = nicknameTextField.text ?? "error nickname"
        authService.setYourProfileData()
        yourProfileImageView.image = UIImage(named: yourProfileUser.nickName)
        yourProfileNicknameLabel.text = yourProfileUser.nickName
    }
    
    
    func setupUI(){
        view.backgroundColor = .systemCyan
        
        view.addSubview(yourProfileNicknameLabel)
        view.addSubview(yourProfileImageView)
        view.addSubview(changeProfilePhotoButton)
        view.addSubview(nicknameTextField)
        view.addSubview(acceptNicknameButton)
                
        yourProfileNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        yourProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        changeProfilePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        acceptNicknameButton.translatesAutoresizingMaskIntoConstraints = false
                                        
        NSLayoutConstraint.activate([
            yourProfileNicknameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            yourProfileNicknameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            yourProfileNicknameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            yourProfileNicknameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            yourProfileImageView.topAnchor.constraint(equalTo: yourProfileNicknameLabel.bottomAnchor, constant: 20),
            yourProfileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            yourProfileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            yourProfileImageView.heightAnchor.constraint(equalToConstant: 140),
            
            changeProfilePhotoButton.topAnchor.constraint(equalTo: yourProfileImageView.bottomAnchor, constant: 20),
            changeProfilePhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            changeProfilePhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            changeProfilePhotoButton.heightAnchor.constraint(equalToConstant: 40),
            
            nicknameTextField.topAnchor.constraint(equalTo: changeProfilePhotoButton.bottomAnchor, constant: 20),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            acceptNicknameButton.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 20),
            acceptNicknameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            acceptNicknameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            acceptNicknameButton.heightAnchor.constraint(equalToConstant: 100),
            ])
    }
    

}


extension YourProfileViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            yourProfileUser.userpic = image
           
            authService.setYourProfileData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
