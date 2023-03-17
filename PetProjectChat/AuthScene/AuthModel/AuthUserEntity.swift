//
//  SignUpUserEntity.swift
//  PetProjectChat
//
//  Created by Кордюков Андрей on 6.03.23.
//

import Foundation

enum AuthResponse {
    case success, error, noVerify
}

struct SignUpEntity {
    var login:String
    var email:String
    var password:String
}

struct SignInEntity {
    var email:String
    var password:String
}

struct ResponseCode {
    var code:Int
}

struct CurrentUser {
    var id:String
    var email:String
}
