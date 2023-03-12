//
//  Menu.swift
//  LittleLemonCapstone
//  By: S.Mayer


import SwiftUI

struct Menu: View {
    
   @State var searchText1 = ""
    var body: some View {
        
        VStack(alignment: .leading) {
                
            Group {
                Hero()
            } 
                
            NavigationView {
                OurDishes()
            }
            .padding(.top, -6)
            .onAppear() {
                UISearchBar.appearance().barTintColor = UIColor.white
            }
                
        }
        .background(Color.llGreen)
    }
}
