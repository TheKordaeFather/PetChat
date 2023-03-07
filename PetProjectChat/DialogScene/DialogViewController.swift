//
//  DialogViewController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 3.03.23.
//

import UIKit




class DialogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        temp()
               
    }
    
    var user:UserProtocol? = User(name: "Monkey D", userpic: UIImage(named: "monkey")!, lastMessage: "хочу жрать", lastMessageDate: "03.03.2023")
    
    func temp(){
        let myView = UIView()
        myView.backgroundColor = .systemBackground
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myView)
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    func createCustomButton(imageName:String, selector:Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemBlue
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
        
        
    }
    
    
    private func setupNavigationBar(){
        let name = user?.name
        let descr = user?.lastMessage
        let pic = user?.userpic
        
        
        let audioRightButton = createCustomButton(imageName: "phone", selector: #selector(didTapAudioRightButton))
        let videoRightButton = createCustomButton(imageName: "video", selector: #selector(didTapVideoRightButton))
        let customTitleView = CustomisedNavigationTitleView(userName: name!, userDescription: descr!, userpic:pic!)
        
//        navigationItem.rightBarButtonItems = [audioRightButton, videoRightButton]
        navigationItem.titleView = customTitleView
        
    }
    
    @objc private func didTapAudioRightButton() {
        print("aidop button")
    }
    
    @objc private func didTapVideoRightButton() {
        print("aidop button")
    }
    
    

}



