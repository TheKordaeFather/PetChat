//
//  UserStorage.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 2.03.23.
//

import Foundation
import UIKit

class UserStorage {
    var list:[UserProtocol] = []
    func saveUsers(){
        
    }
    func loadUsers() {
        self.list = [
            User(name: "Netji", userpic: UIImage(named: "netji")!, lastMessage: "го в доту вечером", lastMessageDate: "02.03.2022"),
            User(name: "Hinata", userpic: UIImage(named: "hinata")!, lastMessage: "глаза сменили тон ты опустела в нем", lastMessageDate: "02.03.2022"),
            User(name: "Naruto", userpic: UIImage(named: "naruto")!, lastMessage: "рамен рамен рамен рамен?", lastMessageDate: "01.03.2022"),
            User(name: "Kakashi", userpic: UIImage(named: "kakashi")!, lastMessage: "монкей д монкей д", lastMessageDate: "25.02.2022"),
            User(name: "Kiba", userpic: UIImage(named: "kiba")!, lastMessage: "я лох собачник", lastMessageDate: "22.02.2022"),
            User(name: "Kabuto", userpic: UIImage(named: "kabuto")!, lastMessage: "я крыса крыса крыса крыса", lastMessageDate: "22.02.2022"),
            User(name: "Rocklee", userpic: UIImage(named: "rocklee")!, lastMessage: "йцуйцуйцуйцуйцу", lastMessageDate: "20.02.2022"),
        ]
    }
    
    init(){
        loadUsers()
    }
}
