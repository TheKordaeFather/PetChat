//
//  DialogViewController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 3.03.23.
//

import UIKit
import InputBarAccessoryView
//import MessageKit


struct Message {
    var message_Id: String
    var date: Date
    var sender_Id: String
    var text: String
        
}

class CertainChatViewController:UIViewController {
    var you:UserProtocol = YourProfileUser.shared
    var companion:UserProtocol! //этот vc не откроется без пользователя
    var conversationID:String?
    var messages:[Message] = []
    
    
    var footerView = FooterView()
    var collectionView:UICollectionView!
        
    
    var rightButton:UIBarButtonItem = {
        let height = UINavigationController().navigationBar.frame.size.height
                
        let b = UIButton()
        b.setTitle("", for: .normal)
        b.layer.masksToBounds = true
        b.layer.cornerRadius = height / 2
        b.setBackgroundImage(UIImage(named: "hinata"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.widthAnchor.constraint(equalToConstant: height).isActive = true
        b.heightAnchor.constraint(equalToConstant: height).isActive = true
        var rb = UIBarButtonItem(customView: b)
        return rb
    }()
    
    var wrapView:UIView = {
        let v = UIView()
        
        return v
    }()
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = "user name"
        view.backgroundColor = .white
        
        setupUI()
        setupConversation() {
            self.collectionView.contentOffset = CGPoint(x: 0, y: 100 * self.messages.count)
        }
        
        
        
       
       
    }
    
    @objc func greenColor(){
        
    }
    
    func setupConversation(completion: @escaping ()->Void){
        if conversationID == nil {
            ChatService.shared.getConversationId(otherId: companion.id) { [weak self] chatId in
               
                
                self?.conversationID = chatId
                ChatService.shared.getAllMessages(chatId: chatId) { [weak self] msgs in
                   
                    self?.messages = msgs
                    self?.collectionView.reloadData()
                    completion()
                }
                
                
            }
        }
        
        
        
    }
    
    
    func setupCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: wrapView.frame, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: "MessageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        
        wrapView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: wrapView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: wrapView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: wrapView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
            ])
        
        
    }
    
    func setupWrapView(){
        
        wrapView.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 60),
            footerView.leftAnchor.constraint(equalTo: wrapView.leftAnchor),
            footerView.rightAnchor.constraint(equalTo: wrapView.rightAnchor),
            footerView.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -10)
            ])
    }
    
    func setupUI(){
        wrapView.backgroundColor = .systemCyan
        
        view.addSubview(wrapView)
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            wrapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        
        setupWrapView()
        setupCollectionView()
    }
    
}

extension CertainChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCollectionViewCell
//        cell.contentView.backgroundColor = .red

        
        
        let messageIndex = indexPath.item
        let senderId = messages[messageIndex].sender_Id
        
        
        if senderId == companion.id {
            cell.contentView.layer.borderWidth = 6
            cell.editCellCompanion(text: messages[messageIndex].text, image: UIImage(named: companion.nickName)!,  num: messageIndex)
        } else {
            cell.contentView.layer.borderWidth = 2
            cell.editCellYou(text: messages[messageIndex].text, image: UIImage(named: you.nickName)!, num: messageIndex)
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: wrapView.frame.width * 0.9, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("нажал на сообщение")
    }
    
    
    
    
}

/*
struct Sender: SenderType {
    var senderId: String
    
    var displayName: String
    
    
}

struct Message: MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
        
}

class CertainChatViewController: MessagesViewController {

    var chatId:String?
    var otherSideId:String?
    let service = ChatService.shared
    
    var user:UserProtocol? = User(name: "Monkey D", userpic: UIImage(named: "monkey")!, lastMessage: "хочу жрать", lastMessageDate: "03.03.2023")
    
    let selfSender = Sender(senderId: "1", displayName: "")
    let otherSideSender = Sender(senderId: "2", displayName: "")
    
    var messages:[Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        showMessageTimestampOnSwipeLeft = true
        
        setupNavigationBar()
//        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        //setupWrapper()
        if chatId == nil {
            service.getConversationId(otherId: otherSideId!) { [weak self]chatId in
                self?.chatId = chatId
                self?.getMessages(convoId: chatId)
            }
        }
        
    }
    
    func getMessages(convoId:String){
        service.getAllMessages(chatId: convoId) {[weak self] messages in
            self?.messages = messages
            self?.messagesCollectionView.reloadDataAndKeepOffset()
        }
    }
    
    
    
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


extension CertainChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate, MessagesDataSource {
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}

extension CertainChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {        
        let msg = Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text(text))
        
        messages.append(msg)
                
        service.sendMessage(otherSideId: self.otherSideId, conversationId: self.chatId, message: msg, text: text) {[weak self] conversationId in
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
                self?.chatId = conversationId
            }
            
        }
        
    }
}
*/
