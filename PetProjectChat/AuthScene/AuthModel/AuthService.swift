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
    
    
    //MARK: -- YourProfile data
   
    func getYourProfileData(){
        let yourProfileUser = YourProfileUser.shared
        let db = Firestore.firestore()
        
        //добавляем инфу об емайле
        yourProfileUser.email = Auth.auth().currentUser?.email ?? "no email???"
        
        guard let yourId = Auth.auth().currentUser?.uid else {
            print("не авторизован")
            return
        }
        //добавляем инфу id
        yourProfileUser.id = yourId       
        
        let docRef = db.collection("users").document(yourId)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()
                //добавляем инфу никнейм
                let nickname = dataDescription?["nickname"] as! String
                yourProfileUser.nickName = nickname
                yourProfileUser.userpic = UIImage(named: nickname) ?? UIImage(systemName: "questionmark")!
                
                } else {
                    print("Document does not exist")
                }
        }

        
       
        
        
    }
    
    func setYourProfileData(){
        let yourProfileUser = YourProfileUser.shared
        let db = Firestore.firestore()
        
        guard let yourId = Auth.auth().currentUser?.uid else {
            print("не авторизован")
            return
        }
        
        
        db.collection("users").document(yourId).updateData(["nickname" : yourProfileUser.nickName]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
}
