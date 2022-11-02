//
//  CachedUser+CoreDataProperties.swift
//  Friendface
//
//  Created by Justin Wells on 11/2/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedId: UUID {
        id ?? UUID()
    }
    
    var wrappedIsActive: Bool {
        isActive
    }
    
    var wrappedName: String {
        name ?? "UNKNOWN"
    }
    
    var wrappedAge: Int16 {
        age
    }
    
    var wrappedCompany: String {
        company ?? "N/A"
    }
    
    var wrappedEmail: String {
        email ?? "UNKNOWN"
    }
    
    var wrappedAddress: String {
        address ?? "UNKNOWN"
    }
    
    var wrappedAbout: String {
        about ?? "UNKNOWN"
    }
    
    var wrappedRegistered: Date {
        registered ?? Date.distantPast
    }
    
    var wrappedTags: String {
        tags ?? ""
    }
    
    var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public static let example = CachedUser()

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
