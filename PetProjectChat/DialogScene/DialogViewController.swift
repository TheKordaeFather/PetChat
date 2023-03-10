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
        
        setupWrapper()
               
    }
    
    var user:UserProtocol? = User(name: "Monkey D", userpic: UIImage(named: "monkey")!, lastMessage: "хочу жрать", lastMessageDate: "03.03.2023")
    
    func setupWrapper(){
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
    
    
    private func setupNavigationBar(){
        let name = user?.name
        let descr = user?.lastMessage
        let pic = user?.userpic
        
        let customTitleView = CustomisedNavigationTitleView(userName: name!, userDescription: descr!, userpic:pic!)
        
        navigationItem.titleView = customTitleView
        
    }
    
}



