//
//  File.swift
//  
//
//  Created by Yiran Zhao on 10/30/19.
//

import Foundation

public struct User: Codable, Equatable, Model {
    public var user_id: Int
    public var username: String
    public var email: String
    public var password: String
    
    public init?(user_id: Int, username: String, email: String, password: String) {
        self.user_id = user_id
        self.username = username
        self.email = email
        self.password = password
    }
    
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.user_id == rhs.user_id
    }
}
