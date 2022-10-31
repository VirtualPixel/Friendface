//
//  CachedUser+CoreDataProperties.swift
//  Friendface
//
//  Created by Justin Wells on 10/31/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: [CachedFriend]?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedIsActive: Bool {
        isActive
    }
    
    public var wrappedName: String {
        name ?? "UNKNOWN"
    }
    
    public var wrappedAge: Int16 {
        age
    }
    
    public var wrappedCompany: String {
        company ?? "N/A"
    }
    
    public var wrappedEmail: String {
        email ?? "UNKNOWN"
    }
    
    public var wrappedAbout: String {
        about ?? "UNKNOWN"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.distantPast
    }
    
    public var wrappedTags: [String] {
        tags ?? []
    }
    
    public var wrappedFriends: [CachedFriend] {
        friends ?? []
    }

}

extension CachedUser : Identifiable {

}
