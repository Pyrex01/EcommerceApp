//
//  Product+CoreDataProperties.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var categorie: String?
    @NSManaged public var count: Int16
    @NSManaged public var des: String?
    @NSManaged public var image: [String]?
    @NSManaged public var name: String?
    @NSManaged public var price: Int16
    @NSManaged public var cart: NSSet?
    @NSManaged public var order: Order?

}

// MARK: Generated accessors for cart
extension Product {

    @objc(addCartObject:)
    @NSManaged public func addToCart(_ value: Cart)

    @objc(removeCartObject:)
    @NSManaged public func removeFromCart(_ value: Cart)

    @objc(addCart:)
    @NSManaged public func addToCart(_ values: NSSet)

    @objc(removeCart:)
    @NSManaged public func removeFromCart(_ values: NSSet)

}

extension Product : Identifiable {

}
