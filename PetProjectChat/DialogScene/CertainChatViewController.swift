//
//  DialogViewController.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 3.03.23.
//

import UIKit
import InputBarAccessoryView
import MessageKit


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
    let service = chatService.shared
    
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
