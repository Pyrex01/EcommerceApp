//
//  User+CoreDataProperties.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var userName: String?
    @NSManaged public var cart: NSSet?
    @NSManaged public var order: NSSet?

}

// MARK: Generated accessors for cart
extension User {

    @objc(addCartObject:)
    @NSManaged public func addToCart(_ value: Cart)

    @objc(removeCartObject:)
    @NSManaged public func removeFromCart(_ value: Cart)

    @objc(addCart:)
    @NSManaged public func addToCart(_ values: NSSet)

    @objc(removeCart:)
    @NSManaged public func removeFromCart(_ values: NSSet)

}

// MARK: Generated accessors for order
extension User {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: Order)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: Order)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}

extension User : Identifiable {

}
