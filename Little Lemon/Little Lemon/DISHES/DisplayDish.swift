//
//  DisplayDish.swift
//  Little Lemon
//
//  By: S.Mayer
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
                    .fontWeight(.medium)
                Text(dish.desc ?? "")
                    .foregroundColor(Color.gray)
                Text(dish.price ?? "")
                    .font(.callout)
                    .monospaced()
                    .foregroundColor(Color.llGreen)
            }
            
            Spacer()
             
            // Currently receiving black image for the fish and dessert dishes from the URL
            AsyncImage(url: URL(string: dish.image!)) { phase in
                if let image = phase.image {
                    image // Displays the loaded image.
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    //Color.gray
                } else {
                    ProgressView() // placeholder
                }
            }
            .frame(width:80, height:80, alignment:.leading)
            .padding(.trailing, 20)  // show arrow indicator
            
        }
        .contentShape(Rectangle()) 
    }
}
