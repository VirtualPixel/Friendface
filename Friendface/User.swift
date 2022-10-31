//
//  User.swift
//  Friendface
//
//  Created by Justin Wells on 10/29/22.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: UUID
    var isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static let example = User(id: UUID(), isActive: true, name: "Justin Wells", age: 27, company: "Allegheny County", email: "wellsmjustin@gmail.com", address: "761 Dunster Street", about: "An iOS developer from Pittsburgh, PA.", registered: Date.now, tags: ["Nub", "Scrub", "Tub"], friends: [Friend(id: UUID(), name: "Bilbo Baggins"), Friend(id: UUID(), name: "Mumbo bumbkins")])
}
