//
//  OurDishes.swift
//  Little Lemon
//
// By: S.Mayer
//

import SwiftUI
import CoreData

struct OurDishes: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishesModel = DishesModel()
    @State private var showAlert = false
    @State var searchText = ""
    
    @State private var category = ""
    @State private var filterSearch = true
    
    var body: some View {
        VStack {
            Spacer()
            VStack() {
                HStack {
                    Text("ORDER FOR DELIVERY")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    Image("deliveryVan")
                       .resizable()
                       .frame(width:40, height:20, alignment:.leading)
                       .aspectRatio(1.0, contentMode: .fit)
                    Spacer()
                }
                 
                ScrollView(.horizontal) {
                    HStack {
                       
                            Button(action: {
                                category = "starters"
                                filterSearch = false
                            },
                                   label: {
                                Text("Starters")
                                    .font(.body)
                                    .foregroundColor(.llGreen)
                                    .padding(6)
                                    .background(Color.llGray)
                                    .cornerRadius(8)
                                    .fontWeight(.bold)
                                
                            })
                            
                            Button(action: {
                                category = "mains"
                                filterSearch = false
                                
                            },
                                   label: {
                                Text("Mains")
                                    .font(.body)
                                    .foregroundColor(.llGreen)
                                    .padding(6)
                                    .background(Color.llGray)
                                    .cornerRadius(8)
                                    .fontWeight(.bold)
                                
                            })
                            
                            Button(action: {
                                category = "desserts"
                                filterSearch = false
                            },
                                   label: {
                                Text("Desserts")
                                    .font(.body)
                                    .foregroundColor(.llGreen)
                                    .padding(6)
                                    .background(Color.llGray)
                                    .cornerRadius(8)
                                    .fontWeight(.bold)
                                
                            })
                            
                            Button(action: {
                                category = "drinks"
                                filterSearch = false
                            },
                                   label: {
                                Text("Drinks")
                                    .font(.body)
                                    .foregroundColor(.llGreen)
                                    .padding(6)
                                    .background(Color.llGray)
                                    .cornerRadius(12)
                                    .fontWeight(.bold)
                                
                            })
                        
                           Button(action: {
                               filterSearch = true
                           },
                                label: {
                              Text("All")
                                .font(.body)
                                .foregroundColor(.llGreen)
                                .padding(6)
                                .background(Color.llGray)
                                .cornerRadius(12)
                                .fontWeight(.bold)
                            
                         })
     
                    }// HStack
                } // Scrollview
                
                Divider()
                    .padding(.top, 10)
                
            } // VStack
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .padding(.bottom, -14)
           
            FetchedObjects(
                    predicate:buildPredicate(filterSearch),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                NavigationLink(destination: ItemDetail(dish)) {
                                    DisplayDish(dish)
                                }
                            }
                        }
                        .padding(.trailing, -20)
                        .padding(.leading, -20)
                        .padding(.top, -20)
                        .background(Color.white)
                        
                        // search bar modifier
                        .searchable(text: $searchText,
                                prompt: "")
                        .cornerRadius(8)
                     
                    }
            
            } // VStack
            .background(Color.llGreen)
          
            // makes the list background invisible, default is gray
            .scrollContentBackground(.hidden)
            
            // runs when the view appears
            .task {
                await dishesModel.getMenuData(viewContext)
            }
            .onAppear() {
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
            }
            
       
    }
    
    func buildPredicate(_ filterSearch:Bool) -> NSPredicate {
        
        // priortize searchbar, regardless of category button press
        if (searchText != "")
        {
           return NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        }
        switch filterSearch {
           case true:
                return NSPredicate(value: true)
                //return searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            
           case false:
               return NSPredicate(format: "category CONTAINS[cd] %@", category)
        }
    }
    
    func buildSortDescriptors () -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "name",
                             ascending: true,
                             selector:
                                #selector(NSString
                                        .localizedStandardCompare))]
    }
       
}
