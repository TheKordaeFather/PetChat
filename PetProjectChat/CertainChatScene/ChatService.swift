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


class ChatService {
    static var shared = ChatService()
    
    init(){}
    
    //получаем список всех пользователей кроме авторизированного(это наши друзья)
    func getAllUsers(completion: @escaping ([UserProtocol]) -> ()) {
        let ref = Firestore.firestore()
        var users:[UserProtocol] = []
        guard let email = Auth.auth().currentUser?.email else { return }
                
        ref.collection("users").whereField("email", isNotEqualTo: email).getDocuments { snap, err in
            
            guard err == nil else {
                return
            }
            
            //все id пользователей
            guard let docs = snap?.documents else {
                return
            }
                
            for doc in docs {
                let data = doc.data()//все поля конкретного документа
                let userId = doc.documentID
                let email = data["email"] as! String //так как в firebase тип any                
                let nickname = data["nickname"] as! String
                let user = User(nickName: nickname, userpic: UIImage(named: nickname)!, email: email, id: userId)                
                users.append(user)                
                                
            }
            
            sleep(3)
            completion(users)

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
//                var sender = Sender(senderId: uid, displayName: "Me")
                for doc in snap.documents {
                    let data = doc.data()
                    
                    let sender_id = data["sender_id"] as! String
                    let message_id = doc.documentID
                    let date = data["date"] as! Timestamp
                    let text = data["text"] as! String
                    
                    let sendDate = date.dateValue()
                    
                    
//                    if userId == uid {
//                        sender = Sender(senderId: "1", displayName: "")
//                    } else {
//                        sender = Sender(senderId: "2", displayName: "")
//                    }
                    
                    msgs.append(Message(message_Id: message_id, date: sendDate, sender_Id: sender_id, text: text))
                }
                completion(msgs)
            }
        }
        
    }
    
    
    /*
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
                "otherSideId":otherSideId!,
                "lastMessage":text
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
                       
            
            Firestore.firestore().collection("conversations").document(conversationId!).updateData(["lastMessage" : text]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    
                }
            }
            
        }
    }
    */
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
    
}
   

    
   
        
    
        
    


    
    
    
    
    
        
    
    
    
        
        

    
    
    
    
    
    
    

    
