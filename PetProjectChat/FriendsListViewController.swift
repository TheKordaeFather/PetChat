//
//  FriendsListViewController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 7.03.23.
//

import UIKit

class FriendsListViewController: UIViewController {
    let userStorage = UserStorage()
    
    private let friendsTableView:UITableView = {
        let tv = UITableView()
        tv.allowsSelection = true
        tv.backgroundColor = .systemBackground
        tv.register(TempTableViewCell.self, forCellReuseIdentifier: TempTableViewCell.cellIdentifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
  
    
    func setupUI(){
        
        view.backgroundColor = .systemCyan
        view.addSubview(friendsTableView)
        friendsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            friendsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            friendsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }

}


extension FriendsListViewController:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStorage.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friendsTableView.dequeueReusableCell(withIdentifier: TempTableViewCell.cellIdentifier, for: indexPath) as? TempTableViewCell else {
            fatalError("The tableview could not dequene customcell in viewcontrolelr")
        }
        let user = userStorage.list[indexPath.row]
        cell.configure(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DialogViewController()
        vc.user = userStorage.list[indexPath.row]
    
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

