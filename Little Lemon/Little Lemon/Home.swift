//
//  Home.swift
//  LittleLemonCapstone
//  By: S.Mayer


import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .tag(0)
                .tabItem {
                   Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tag(1)
                .tabItem {
                   Label("Profile", systemImage: "square.and.pencil")
                }
        } //TabView
        .navigationBarBackButtonHidden(true)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
