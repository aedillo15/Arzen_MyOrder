//
//  Order.swift
//  Arzen_MyOrder
//
//  Created by Arzen Edillo on 2021-09-30.
//  StudentID: 991579073
//

import Foundation
struct Order : Identifiable, Hashable{
    
    var id = UUID()
    var coffeeType : String = ""
    var coffeeSize : String = ""
    var quantity : String = ""
    
    
    init(coffeeType: String, coffeeSize: String, quantity: String){
        self.coffeeType = coffeeType
        self.coffeeSize = coffeeSize
        self.quantity = quantity
    }
}
