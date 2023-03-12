//
//  DishesModel.swift
//  Little Lemon
//
//  By: S.Mayer
//

import Foundation
import CoreData


@MainActor
class DishesModel: ObservableObject {
    
    @Published var menuItems = [MenuItem]()
        
    
    func getMenuData(_ coreDataContext:NSManagedObjectContext) async {
        
        
        let url = URL(string:
            "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        
        
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            menuItems = fullMenu.menu
            
            // Calling any of the delete functions below cause duplicate items to be inserted into Core Data for some reason
            // probably due to a Core Data bug,
            // so I'll comment it out for now. The createDishesFrom function below will only insert into Core Data if
            // the item doesn't already exist, so this is the workaround for now.
            //Dish.deleteAll(coreDataContext)
            //PersistenceController.shared.clear()
            
            // populate Core Data - insert items if they doesn't already exist
            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        }
        catch { }
    }
}



func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}


extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func itemsTask(with url: URL, completionHandler: @escaping (MenuList?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

