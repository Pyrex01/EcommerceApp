//
//  Order+CoreDataProperties.swift
//  Ecomeerce
//
//  Created by Riyan Khan on 01/05/23.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var status: String?
    @NSManaged public var time: Date?
    @NSManaged public var count: Int32
    @NSManaged public var attribute: NSObject?
    @NSManaged public var product: Product?
    @NSManaged public var user: User?

}

extension Order : Identifiable {

}
