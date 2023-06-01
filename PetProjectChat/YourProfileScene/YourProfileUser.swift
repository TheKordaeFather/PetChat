//
//  YourProfileUser.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 17.03.23.
//

import Foundation
import UIKit

class YourProfileUser : UserProtocol{
    static var shared = YourProfileUser()
    
    init(){}
    
    var name:String = ""
    var nickName:String = "" //добавляется
    var email:String = "" //добавляется
    var id:String = "" //добавляется
    var password:String = ""
    var lastMessage:String = ""
    var lastMessageDate:String = ""
    var userpic:UIImage = UIImage(systemName: "questionmark")!
    
    var friendList:[UserProtocol] = []
   
}
