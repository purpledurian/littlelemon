//
//  ItemDetail.swift
//  Little Lemon
//
//  Created by S.Mayer on 3/12/23.
//

import SwiftUI

struct ItemDetail: View {
    
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    @State private var quantity = ""
    @State private var showAlert = false
    
    var body: some View {
        
        ScrollView {
            HStack {
                 AsyncImage(url: URL(string: dish.image!)) { image in
                 image
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(8)
                    .padding([.leading, .trailing], 10)
                 } placeholder: {
                    ProgressView()
                 }
                
            }
            
            VStack (alignment: .leading) {
                Text(dish.name ?? "")
                    .fontWeight(.semibold)
                    .font(.title3)
                
                Text(dish.desc ?? "")
                    .foregroundColor(Color.gray)
                
                Text("$" + (dish.price ?? ""))
                    .font(.callout)
                    .monospaced()
                    .foregroundColor(Color.llGreen)
                
                HStack {
                    Text("Quantity")
                    TextField("1",
                              text: $quantity)
                       .padding(.leading, 10)
                       .foregroundColor(Color.llGreen)
                       .textFieldStyle(.roundedBorder)
                       .frame(width: 80)
                       .keyboardType(.numberPad)
                }
            }
            .padding()
            
        } // ScrollView
        
        Spacer()
        
        Button(action: {
            showAlert.toggle()
        },
               label: {
            Text("Order")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.llGreen)
                .cornerRadius(8)
                .padding([.leading, .trailing], 10)
                .padding(.bottom, 10)
            
        })
        .alert("Order placed!",
               isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}



