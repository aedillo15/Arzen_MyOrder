//
//  OrderMO.swift
//  Arzen_MyOrder
//
//  Created by Arzen Edillo on 2021-10-14.
//

import Foundation
import CoreData

@objc(OrderMO)
final class OrderMO: NSManagedObject{
    
    @NSManaged var id : UUID?
    @NSManaged var coffeeType : String
    @NSManaged var coffeeSize : String
    @NSManaged var quantity : String
    @NSManaged var dateAdded: Date
}

extension OrderMO{
    func convertToOrder() -> Order{
        Order(coffeeType: coffeeType, coffeeSize: coffeeSize, quantity: quantity)
    }
}



