//
//  User.swift
//  Friendface
//
//  Created by Justin Wells on 10/29/22.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    var isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
