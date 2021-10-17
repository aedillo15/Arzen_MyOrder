//
//  CoreDBHelper.swift
//  Arzen_MyOrder
//
//  Created by Arzen Edillo on 2021-10-14.
//

import Foundation
import CoreData

class CoreDBHelper : ObservableObject{
    
    @Published var orderList = [OrderMO]()
    
    private let ENTITY_NAME = "OrderMO"
    private let MOC : NSManagedObjectContext
    
    private static var shared: CoreDBHelper?
    
    static func getInstance() -> CoreDBHelper{
        if shared == nil{
            shared = CoreDBHelper(context: PersistenceController.preview.container.viewContext)
        }
        return shared!
    }
    
    init(context: NSManagedObjectContext) {
        self.MOC = context
    }
    
    func insertOrder(newOrder: Order){
        do{
            //get the object reference of NSEntityDescription
            let orderTobeInserted = NSEntityDescription.insertNewObject(forEntityName: self.ENTITY_NAME, into: self.MOC) as! OrderMO
            //assign variables to the object reference of NSEntityDescription
            orderTobeInserted.coffeeType = newOrder.coffeeType
            orderTobeInserted.coffeeSize = newOrder.coffeeSize
            orderTobeInserted.quantity = newOrder.quantity
            orderTobeInserted.id = UUID()
            orderTobeInserted.dateAdded = Date()
            
            print(orderTobeInserted.quantity)
            
            //saved obj db
            if self.MOC.hasChanges{
                try self.MOC.save()
                print(#function, "Order successfully added to DB")
            }
            
        }catch let error as NSError{
            print(#function, "Could not insert order successfully \(error)")
        }
    }
    
    func getAllOrders(){
        let fetchRequest = NSFetchRequest<OrderMO>(entityName: self.ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "coffeeType", ascending: true)]
        
        do{
            let result = try self.MOC.fetch(fetchRequest)
            print(#function, "Number of records : \(result.count)")
            self.orderList.removeAll()
            self.orderList.insert(contentsOf: result, at: 0)
            print(#function, "Result from DB \(result)")
            
        }catch let error as NSError{
            print(#function, "Couldn't fetch data from DB \(error)")
        }
    }
    
    private func searchOrder(orderID : UUID) -> OrderMO?{
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", orderID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.MOC.fetch(fetchRequest)
            
            if result.count > 0{
                return result.first as? OrderMO
            }
            
        }catch let error as NSError{
            print(#function, "Unable to search for given ID \(error)")
        }
        
        return nil
    }
    
    func deleteOrder(orderID : UUID){
        let searchResult = self.searchOrder(orderID: orderID)
        
        if (searchResult != nil){
            //if matching object found
            
            do{
        
                self.MOC.delete(searchResult!)
                
                try self.MOC.save()
                
                print(#function, "Data deleted successfully")
                
            }catch let error as NSError{
                print(#function, "Unable to search for given ID \(error)")
            }
            
        }else{
            print(#function, "No matching record found for given orderID \(orderID)")
        }
    }
    
    func updateOrder(updatedOrder: OrderMO){
        let searchResult = self.searchOrder(orderID: updatedOrder.id! as UUID)
        
        if (searchResult != nil){
            do{
                
                let orderToUpdate = searchResult!
                orderToUpdate.coffeeType = updatedOrder.coffeeType
                orderToUpdate.coffeeSize = updatedOrder.coffeeSize
                orderToUpdate.quantity = updatedOrder.quantity
                
                try self.MOC.save()
                
                print(#function, "Order details updated successfully")
                
            }catch let error as NSError{
                print(#function, "Unable to search for given ID \(error)")
            }
        }else{
            print(#function, "No matching record found for given orderID \(updatedOrder.id!)")
        }
    }
    

}
