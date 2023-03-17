//
//  ChatService.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 14.03.23.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class chatService {
    static var shared = chatService()
    
    init(){}
    
    func getAllUsers(completion: @escaping ([UserProtocol]) -> ()){
        guard let email = Auth.auth().currentUser?.email else { return }
        var users:[UserProtocol] = []
        
        Firestore.firestore().collection("users").whereField("email", isNotEqualTo: email).getDocuments { snap, err in
            
            guard err == nil else {
                return
            }
            
            //все id пользователей
            guard let docs = snap?.documents else {
                return
            }
            //нужно создать какой нибудь адекватный класс где будут хранить эту имя возраст картинку и тд
                        
            for doc in docs {
                let data = doc.data()
                let userId = doc.documentID
                let email = data["email"] as! String
                let user = User(name: "qwe", userpic: UIImage(named: "naruto")!, email: email, id: userId)
                user.lastMessage = "jdjhfdbhdf"
                user.lastMessageDate = "28.02.2022"
                users.append(user)
                                
            }
            completion(users)
            
        }
    }
    
    //MARK: -- Messenger
    func sendMessage(otherSideId:String?, conversationId:String?, message: Message, text:String, completion: @escaping (String) -> () ){
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("не авторизован")
            return
        }
        
        
        if conversationId == nil {
            //создаем новую переписку
            print("создаем новую переписку")
            let newConversationId = UUID().uuidString
            let selfData:[String:Any] = [
                "date":Date(),
                "otherSideId":otherSideId!,
            ]
            let otherData:[String:Any] = [
                "date":Date(),
                "otherSideId":uid,
            ]
            //у нас есть переписка с человеком Х
            Firestore.firestore().collection("users").document(uid).collection("conversation").document(newConversationId).setData(selfData)
            
            Firestore.firestore().collection("users").document(otherSideId!).collection("conversation").document(newConversationId).setData(otherData)
            
            let msg:[String:Any] = [
                "date":Date(),
                "sender_id":uid,
                "text":text
            ]
            
            let conversationInfo: [String:Any] = [
                "date":Date(),
                "selfSender":uid,
                "otherSideId":otherSideId!
            ]
            
            Firestore.firestore().collection("conversations").document(newConversationId).setData(conversationInfo) { err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("conversations").document(newConversationId).collection("messages").addDocument(data: msg) { err in
                    if err == nil {
                        completion(newConversationId)
                    } else {
                        completion(newConversationId)
                    }
                }
            }
            
            
        } else {
            let msg:[String:Any] = [
                "date":Date(),
                "sender_id":uid,
                "text":text
            ]
            
            Firestore.firestore().collection("conversations").document(conversationId!).collection("messages").addDocument(data:  msg) { err in
                if err == nil {
                    completion(conversationId!)
                } else {
                    completion(conversationId!)
                }
            }
        }
    }
    
    func updateConversation(){
        
    }
    
    func getConversationId(otherId:String, completion: @escaping (String) -> () ){
        guard let uid = Auth.auth().currentUser?.uid else {
            print("не авторизован")
            return
        }
        
        Firestore.firestore().collection("users").document(uid).collection("conversation").whereField("otherSideId", isEqualTo: otherId).getDocuments { snap, err in
            if err != nil {
                return
            }
            
            if let snap = snap, !snap.documents.isEmpty {
                let doc = snap.documents.first
            
                if let convoId = doc?.documentID {
            
                    completion(convoId)
                }
            }
        }
    }
    
    func getAllMessages(chatId:String, completion: @escaping ([Message]) -> () ){
        guard let uid = Auth.auth().currentUser?.uid else {
            print("не авторизован")
            return
        }
        
        
        Firestore.firestore().collection("conversations").document(chatId).collection("messages").limit(to: 50).order(by: "date", descending: false).addSnapshotListener {  snap, err in
            if err != nil {
                return
            }
            
            if let snap = snap, !snap.documents.isEmpty {
                var msgs:[Message] = []
                var sender = Sender(senderId: uid, displayName: "Me")
                for doc in snap.documents {
                    let data = doc.data()
                    let userId = data["sender_id"] as! String
                    
                    
                    
                    let messageId = doc.documentID
                    let date = data["date"] as! Timestamp
                    let sendDate = date.dateValue()
                    let text = data["text"] as! String
                    
                    if userId == uid {
                        sender = Sender(senderId: "1", displayName: "")
                    } else {
                        sender = Sender(senderId: "2", displayName: "")
                    }                                       
                    
                    msgs.append(Message(sender: sender, messageId: messageId, sentDate: sendDate, kind: .text(text)))
                }
                completion(msgs)
            }
        }
        
    }
    
    func getOneMessage(){
        
    }
}
