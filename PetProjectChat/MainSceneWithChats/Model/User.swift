//
//  User.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 2.03.23.
//

import Foundation
import UIKit


class User : UserProtocol{
    var name:String
    var nickName:String = ""
    var email:String = ""
    var id:String = ""
    var password:String = ""
    var lastMessage:String = ""
    var lastMessageDate:String = ""
    var userpic:UIImage
    
    init(name:String, userpic:UIImage) {
        self.name = name
        self.userpic = userpic
    }
    
    init(name:String, userpic:UIImage, lastMessage:String, lastMessageDate:String) {
        self.name = name
        self.userpic = userpic
        self.lastMessage = lastMessage
        self.lastMessageDate = lastMessageDate
    }
    
    init(name:String, userpic:UIImage, email:String, id:String) {
        self.name = name
        self.userpic = userpic
        self.email = email
        self.id = id
    }
}
