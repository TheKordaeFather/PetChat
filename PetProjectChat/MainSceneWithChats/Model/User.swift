//
//  User.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 2.03.23.
//

import Foundation
import UIKit


class User : UserProtocol{
    var name:String = ""
    var nickName:String
    var email:String = "" //добавляется
    var id:String = "" //добавляется
    var password:String = ""
    var lastMessage:String = ""
    var lastMessageDate:String = ""
    var userpic:UIImage
    
    init(nickName:String, userpic:UIImage) {
        self.nickName = nickName
        self.userpic = userpic
    }
    
    init(nickName:String, userpic:UIImage, lastMessage:String, lastMessageDate:String) {
        self.nickName = nickName
        self.userpic = userpic
        self.lastMessage = lastMessage
        self.lastMessageDate = lastMessageDate
    }
    
    init(nickName:String, userpic:UIImage, email:String, id:String) {
        self.nickName = nickName
        self.userpic = userpic
        self.email = email
        self.id = id
    }
}
