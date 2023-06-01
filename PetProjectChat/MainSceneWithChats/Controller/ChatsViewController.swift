//
//  MainController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 24.02.23.
//

import UIKit

class ChatsViewController: UIViewController {
    private let cellIdentifire = "cellID"
    let yourProfileUser = YourProfileUser.shared
        
    var userStorage:[UserProtocol] = []
    var searchStorage:[UserProtocol] = []
    // MARK: all images
    
    let searchBar = UISearchBar()
    
    //аватарка с картинкой своего профиля
    let yourProfileSegue:UIButton = {
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
    
    //переключатель на диалоги и друзей
    private let friendsDialogsSegmentControl:UISegmentedControl = {
        let items = ["dialogs", "friend"]
        let sc = UISegmentedControl(items: items)
        //sc.addTarget(self, action: #selector(changeTableView), for: .valueChanged)
        //если оставть addTarget тут то он не будет работать если я нажму searchbar
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    //обертка для группировки friendsDialogsSegmentControl и dialogsTableView
    var backgroundView:UIView! //tableViewAndSegmentControlWrapper
    
    let dialogsTableView:UITableView = {
        let tv = UITableView()
        tv.allowsSelection = true
        tv.backgroundColor = .systemBackground
        tv.register(ExtendedTableViewCell.self, forCellReuseIdentifier: ExtendedTableViewCell.cellIdentifier)
        return tv
    }()
    
   
    override func viewDidAppear(_ animated: Bool) {
        friendsDialogsSegmentControl.selectedSegmentIndex = 0
        yourProfileSegue.setBackgroundImage(UIImage(named: yourProfileUser.nickName), for: .normal)
        
        self.dialogsTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        dialogsTableView.delegate = self
        dialogsTableView.dataSource = self
        searchBar.delegate = self
        
        setupUI()
        
        userStorage = YourProfileUser.shared.friendList        
        
    }
    
    //переход на свой профиль
    @objc func yourProfileButtonDidTap() {
//        let vc = CertainChatViewController()
//        navigationController?.pushViewController(vc, animated: true)
//        self.dialogsTableView.reloadData()
        let vc = YourProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //переход на список друзей
    @objc func changeTableView(){        
        if friendsDialogsSegmentControl.selectedSegmentIndex == 1 {
            let vc = FriendsListViewController()
            vc.userStorage = self.userStorage
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    func setupUI(){
        configureNavigationBar()
        configureBackgroundView()
        
        view.addSubview(backgroundView)
                
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
                                        
        NSLayoutConstraint.activate([
                       
            backgroundView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    func configureNavigationBar(){

        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: yourProfileSegue)
        yourProfileSegue.addTarget(self, action: #selector(yourProfileButtonDidTap), for: .touchUpInside)
        
        

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchDidTap))
//        searchBar.sizeToFit()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        как по-человечески сделать системную кнопку в баре
        
    }
    
    func configureBackgroundView(){
        friendsDialogsSegmentControl.addTarget(self, action: #selector(changeTableView), for: .valueChanged)
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .systemCyan
        
        backgroundView.addSubview(friendsDialogsSegmentControl)
        backgroundView.addSubview(dialogsTableView)
        friendsDialogsSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        dialogsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            friendsDialogsSegmentControl.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            friendsDialogsSegmentControl.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 4),
            backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: friendsDialogsSegmentControl.trailingAnchor, multiplier: 4),
            
            
            dialogsTableView.topAnchor.constraint(equalTo: friendsDialogsSegmentControl.bottomAnchor, constant: 10),
            dialogsTableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            dialogsTableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            dialogsTableView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            ])
    }
}

extension ChatsViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchStorage.removeAll()
        
        guard searchText != "" || searchText != " " else {
            searchStorage = userStorage
            return
        }
        
        let text = searchText.lowercased()
        
        for user in userStorage {
            let isArrayContain = user.name.lowercased().range(of: text)
            if isArrayContain != nil {
                searchStorage.append(user)
            }
            
        }
        self.dialogsTableView.reloadData()
        
    }
}

extension ChatsViewController:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchStorage.count > 0 {
            return searchStorage.count
        } else {
            return userStorage.count
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
            user = userStorage[indexPath.row]            
        }
                        
        cell.configure(user: user, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = CertainChatViewController()
        if searchStorage.count > 0 {
            vc.companion = searchStorage[indexPath.row]
        } else {
            vc.companion = userStorage[indexPath.row]
           
        }
        
        
//        vc.otherSideId = vc.user?.id
    
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
