//
//  User+CoreDataProperties.swift
//  FriendsList
//
//  Created by Santiago Pelaez Rua on 12/03/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var tags: NSObject?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var about: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedName: String { name ?? "Unknown name" }
    public var wrappedEmail: String { email ?? "Unknown email" }

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
