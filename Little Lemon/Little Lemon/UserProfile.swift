//
//  UserProfile.swift
//  LittleLemonCapstone
//  By: S.M


import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Personal Information")
                Spacer()
            }
            Image("profile-image-placeholder")
               .resizable()
               .frame(width:50, height:50, alignment:.leading)
               .aspectRatio(1.0, contentMode: .fit)
               .clipShape(Circle())
            
            Text("First name:")
            Text(firstName)
            Text("Last name:")
            Text(lastName)
            Text("Email:")
            Text(email)
            
            Button(action: {
                
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                //go back to the previous screen which is Onboarding simulating logout
                self.presentation.wrappedValue.dismiss()
                
            },
                   label: {
                Text("Log out")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(8)
                
            })
           
            Spacer()
        }
        .padding()
        .background(Color.yellow)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
