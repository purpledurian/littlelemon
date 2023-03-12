//
//  Dish+Extension.swift
//  Little Lemon
//
//  By: S.Mayer
//

import Foundation
import CoreData


extension Dish {

    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        
        menuItems.forEach { item in
            
            if !alreadyExists(item.title, context) {
                let dish = Dish(context: context)
                dish.name = item.title
                dish.price = item.price
                dish.desc = item.description
                dish.category = item.category
                dish.image = item.image
               
            }
            
        }
        
        try? context.save()
    
    }
    
    // According to sample JSON data, we assume the returned dish names are unique, and dish menu items are only
    // available in one size
    private static func alreadyExists(_ name:String, _ context:NSManagedObjectContext) -> Bool {
        
        return Dish.exists(name: name, context)
        
    }
    
}
