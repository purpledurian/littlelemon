//
//  UserProfile.swift
//  LittleLemonCapstone
//  By: S.Mayer


import SwiftUI

let kspecialOffers = "kspecialOffers"
let knewsletter = "knewsletter"

struct UserProfile: View {
    
    @State private var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State private var showAlert = false
    @State private var selectSpecialOffers = UserDefaults.standard.bool(forKey: kspecialOffers)
    @State private var selectNewsletter = UserDefaults.standard.bool(forKey: knewsletter)
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ScrollView {
                
                HStack {
                    Text("Personal Information")
                        .padding()
                        .font(.title)
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Button(action: {
                        showAlert.toggle()
                    }) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .frame(width:80, height:80, alignment:.leading)
                            .aspectRatio(1.0, contentMode: .fit)
                            .clipShape(Circle())
                            .padding(.leading, 20)
                    }
                    .alert("Photo update not implemented yet!",
                           isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                    
                    Text("First name *")
                       .font(.body)
                       .padding([.leading, .top], 20)
                       .foregroundColor(Color.gray)
                       .fontWeight(.bold)
                        
                    TextField("First Name",
                        text: $firstName)
                       .padding([.leading, .trailing], 20)
                       .textFieldStyle(.roundedBorder)
                        
                    Text("Last name *")
                       .font(.body)
                       .padding([.leading, .top], 20)
                       .foregroundColor(Color.gray)
                       .fontWeight(.bold)
                        
                    TextField("Last Name",
                        text:$lastName
                    )
                       .padding([.leading, .trailing,], 20)
                       .textFieldStyle(.roundedBorder)

                    Text("Email *")
                        .font(.body)
                        .padding([.leading, .top], 20)
                        .foregroundColor(Color.gray)
                        .fontWeight(.bold)
                        
                    TextField("Email",
                        text: $email
                    )
                       .padding([.leading, .trailing,], 20)
                       .textFieldStyle(.roundedBorder)
                       .keyboardType(.emailAddress)
                       .textContentType(.emailAddress)
                       .disableAutocorrection(true)
                       .autocapitalization(.none)
                    
                    Text("Subscriptions")
                       .font(.title3)
                       .padding([.top, .leading] ,20)
                    
                    HStack {
                        
                        CheckMarkButton(selectButton: $selectSpecialOffers)
                        
                        Text("Special offers")
                            .font(.body)
                            .padding(.leading, 10)
                            
                    }
                    
                    HStack {
                        
                        CheckMarkButton(selectButton: $selectNewsletter)
                        
                        Text("Newsletter")
                            .font(.body)
                            .padding(.leading, 10)
                    }
                        
                } //VStack
                
                } // Scrollview
                
                Spacer()
            
                Button(action: {
                    
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                    UserDefaults.standard.set(selectSpecialOffers, forKey: kspecialOffers)
                    UserDefaults.standard.set(selectNewsletter, forKey: knewsletter)
                    
                    
                },
                       label: {
                    Text("Save")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.llGreen)
                        .cornerRadius(8)
                        .padding([.bottom, .leading, .trailing], 10)
                    
                })
                
                Button(action: {
                    
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    UserDefaults.standard.set("", forKey: kFirstName)
                    UserDefaults.standard.set("", forKey: kLastName)
                    UserDefaults.standard.set("", forKey: kEmail)
                    UserDefaults.standard.set(true, forKey: kspecialOffers)
                    UserDefaults.standard.set(true, forKey: knewsletter)
                    
                    
                    UserDefaults.standard.synchronize()
                    //go back to the previous screen which is Onboarding simulating logout
                    self.presentation.wrappedValue.dismiss()
                    
                },
                       label: {
                    Text("Log out")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.title2)
                        .foregroundColor(.llGreen)
                        .padding()
                        .background(Color.llYellow)
                        .cornerRadius(8)
                        .padding([.bottom, .leading, .trailing], 10)
                    
                })
                
        }
        .background(Color.white)
    }
}

struct CheckMarkButton:View {
    @Binding var selectButton:Bool
    var body: some View {
        Button(action: {
            selectButton.toggle()
        }) {
            
            if selectButton {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 10, height: 10, alignment:.leading)
                    .foregroundColor(.white)
                    .padding(6)
                    .aspectRatio(1.0, contentMode: .fit)
                    .background(Color.llGreen)
                    .cornerRadius(4)
                    .bold(true)
                    .padding(.leading, 20)
            }
            else {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 10, height: 10, alignment:.leading)
                    .foregroundColor(Color.llGray)
                    .padding(6)
                    .aspectRatio(1.0, contentMode: .fit)
                    .background(Color.llGray)
                    .cornerRadius(4)
                    .padding(.leading, 20)
                
            }
        } 
    
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
