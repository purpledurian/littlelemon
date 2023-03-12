//
//  Hero.swift
//  Little Lemon
//
//  Created by S.Mayer 3/12/23.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.largeTitle)
                .foregroundColor(Color.llYellow)
                .fontWeight(.semibold)
                .padding(.leading, 10)
                .padding(.top, 10)
            
            Text("Chicago")
                .font(.title2)
                .foregroundColor(Color.white)
                .fontWeight(.semibold)
                .padding(.leading, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .foregroundColor(Color.white)
                        .padding([.top, .leading], 10)
                }
                
                Spacer()
                
                Image("Hero")
                    .resizable()
                    .frame(width:140, height:140, alignment:.leading)
                    .aspectRatio(1.0, contentMode: .fit)
                    .cornerRadius(8)
                    .padding([.trailing, .bottom], 10)
                
            }
        }
        .background(Color.llGreen)
    }
       
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}
