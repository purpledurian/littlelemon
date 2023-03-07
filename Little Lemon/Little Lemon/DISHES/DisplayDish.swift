//
//  DisplayDish.swift
//  Little Lemon
//
//  By: S.M
//

import SwiftUI


struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        HStack {
            
            VStack (alignment: .leading) {
                Text(dish.name ?? "")
                //Spacer()
                Text(dish.desc ?? "")
                Text(dish.price ?? "")
                    .font(.callout)
                    .monospaced()
            }
            
            AsyncImage(url: URL(string: dish.image!)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
               //.resizable()
               .frame(width:50, height:50, alignment:.leading)
               //.aspectRatio(1.0)
               //.contentMode: .fit
               //.clipShape(Circle())
        }
        //EmptyView()
        .contentShape(Rectangle()) // keep this code
    }
}
