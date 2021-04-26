//
//  User.swift
//  FriendsList
//
//  Created by Santiago Pelaez Rua on 11/03/21.
//

import Foundation

struct UserStruct: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [FriendStruct]
}
