//
//  MainController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 24.02.23.
//

import UIKit

class MainVC: UIViewController {
    private let cellIdentifire = "cellID"
    // MARK: all images
    let searchBar = UISearchBar()
    
    
    
    let userStorage = UserStorage()
    
    
    
    var searchStorage:[UserProtocol] = []
    
    private let friendsDialogsSegmentControl:UISegmentedControl = {
        let items = ["dialogs", "friend"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let dialogsTableView:UITableView = {
        let tv = UITableView()
        tv.allowsSelection = true
        tv.backgroundColor = .systemBackground
//        tv.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tv.register(ExtendedTableViewCell.self, forCellReuseIdentifier: ExtendedTableViewCell.cellIdentifier)
        return tv
    }()
    
    let button:UIButton = {
        let b = UIButton()
        b.setTitle("", for: .normal)
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 22
        b.setBackgroundImage(UIImage(named: "monkey"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.widthAnchor.constraint(equalToConstant: 44).isActive = true
        b.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        dialogsTableView.delegate = self
        dialogsTableView.dataSource = self
        searchBar.delegate = self
        setupUI()
        configureNavigationBar()
        
    }
    
    func configureNavigationBar(){
//        searchBar.sizeToFit()
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchDidTap))
//        как по-человечески сделать системную кнопку в баре
        
    }
    
    @objc func buttonDidTap() {
        let vc = DialogViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI(){
        view.addSubview(friendsDialogsSegmentControl)
        view.addSubview(dialogsTableView)
        friendsDialogsSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        dialogsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            friendsDialogsSegmentControl.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            friendsDialogsSegmentControl.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: friendsDialogsSegmentControl.trailingAnchor, multiplier: 4),
            
            
            dialogsTableView.topAnchor.constraint(equalTo: friendsDialogsSegmentControl.bottomAnchor, constant: 10),
            dialogsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dialogsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dialogsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
}

extension MainVC:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchStorage.removeAll()
        
        guard searchText != "" || searchText != " " else {
            searchStorage = userStorage.list
            return
        }
        
        let text = searchText.lowercased()
        
        for user in userStorage.list {
            let isArrayContain = user.name.lowercased().range(of: text)
            if isArrayContain != nil {
                searchStorage.append(user)
            }
            
        }
        self.dialogsTableView.reloadData()
        
    }
}

extension MainVC:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchStorage.count > 0 {
            return searchStorage.count
        } else {
            return userStorage.list.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dialogsTableView.dequeueReusableCell(withIdentifier: ExtendedTableViewCell.cellIdentifier, for: indexPath) as? ExtendedTableViewCell else {
            fatalError("The tableview could not dequene customcell in viewcontrolelr")
        }
        
        let user:UserProtocol
        if searchStorage.count > 0 {
            user = searchStorage[indexPath.row]
        } else {
            user = userStorage.list[indexPath.row]
        }
        
        
        cell.configure(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DialogViewController()
        print(searchStorage.count)
        if searchStorage.count > 0 {
            vc.user = searchStorage[indexPath.row]
        } else {
            vc.user = userStorage.list[indexPath.row]
        }
        
        
    
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
