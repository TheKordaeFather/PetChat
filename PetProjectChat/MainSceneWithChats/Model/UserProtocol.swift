//
//  UserProtocol.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 2.03.23.
//


import UIKit

protocol UserProtocol {
    var name:String { get set }
    var nickName:String { get set }
    var email:String { get set } //добавляется
    var id:String { get set } //добавляется
    var password:String { get set }
    var userpic:UIImage { get set }
    var lastMessage:String { get set }
    var lastMessageDate:String { get set }
}
