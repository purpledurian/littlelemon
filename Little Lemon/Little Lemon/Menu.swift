//
//  Menu.swift
//  LittleLemonCapstone
//  By: S.M


import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family restaurant")
            List {
                
            }
        }
        .padding()
        .background(Color.yellow)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
