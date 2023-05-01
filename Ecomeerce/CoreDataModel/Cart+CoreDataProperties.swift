//
//  Cart+CoreDataProperties.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var count: Int32
    @NSManaged public var product: Product?
    @NSManaged public var user: User?

}

extension Cart : Identifiable {

}
