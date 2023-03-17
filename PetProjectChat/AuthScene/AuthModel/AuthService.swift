//
//  AuthService.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 6.03.23.
//
 
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore




class AuthService {
    static var shared = AuthService()
    
    init(){}
    
    func createNewUser(_ data:SignUpEntity, completion: @escaping (ResponseCode)->()){
        let email = data.email
        let password = data.password
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result , err in
            if err == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data:[String:Any] = ["email":email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                                                            
                    completion(ResponseCode(code: 1))
                }
            } else {
                completion(ResponseCode(code: 0))
            }
        }
    }
    
    func confirmEmail(){
        Auth.auth().currentUser?.sendEmailVerification(completion: { err in
            if err != nil {
                print(err?.localizedDescription)
            }
        })
    }
    
    func signIn(_ data:SignInEntity, completion: @escaping (AuthResponse) -> () ){
        let email = data.email
        let password = data.password
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if err != nil {
                completion(.error)
            } else {
                if let result = result {
                    
                    guard result.user.isEmailVerified else {
                        self.confirmEmail()
                        completion(AuthResponse.noVerify)
                        return
                    }
                    
                    let userInfo = result.additionalUserInfo                                                    
                    completion(AuthResponse.success)
                }
            }
        }
    }
    
    func getAllUsers(completion: @escaping ([String]) -> ()){
        Firestore.firestore().collection("users").getDocuments { snap, err in
            
            guard err == nil else {
                return
            }
            
            //все id пользователей
            guard let docs = snap?.documents else {
                return
            }
            //нужно создать какой нибудь адекватный класс где будут хранить эту имя возраст картинку и тд
            
            var tempList:[String] = []
            for doc in docs {
                let data = doc.data()
                let email = data["email"] as! String
                
                tempList.append(email)
            }
            completion(tempList)
            
        }
    }
    
    //MARK: -- Messenger
    func sendMessage(otherSideId:String?, conversationId:String?, message: Message, text:String, completion: @escaping (Bool) -> () ){
        if conversationId == nil {
            //создаем новую переписку
        } else {
            let msg:[String:Any] = [
                "date":Date(),
                "sender_id":message.sender.senderId,
                "text":text
            ]
            Firestore.firestore().collection("conversations").document(conversationId!).collection("messages").addDocument(data:  msg) { err in
                if err == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func updateConversation(){
        
    }
    
    func getConversationId(){
        
    }
    
    func getAllMessages(){
        
    }
    
    func getOneMessage(){
        
    }
}
