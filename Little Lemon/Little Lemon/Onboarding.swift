//
//  Onboarding.swift
//  LittleLemonCapstone
//  By: S.M


import SwiftUI

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var errorMessage:String = "First name, Last name, and email are required fields"
    @State private var showErrorMessage: Bool = false
    
    @State private var isLoggedIn = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading)  {
                
                NavigationLink(destination: Home(),isActive: $isLoggedIn) {
                        // empty view here since nav is
                        // is activated by button setting
                        // isLoggedIn to true
                        EmptyView()
                }
                
                //HStack {
                    Text("First name *")
                        .font(.subheadline)
                    
                    TextField("First Name",
                              text: $firstName)
                //}
                
                //HStack {
                    Text("Last name *")
                        .font(.subheadline)
                    
                    TextField("Last Name",
                              text: $lastName
                    )
                //}
                
                //HStack {
                    Text("Email *")
                        .font(.subheadline)
                    
                    TextField("Email",
                              text: $email
                    )
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                //}
                
                Button(action: {
                    
                    /*
                     
                     presentationMode.wrappedValue.dismiss()
                     }
                     */
                    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
                        showErrorMessage = true
                    }
                    else if (!isValid(email: email)) {
                        errorMessage = "Email address is invalid"
                        showErrorMessage = true
                    }
                    else {
                        isLoggedIn = true
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
                    }
                    
                }, // button
                       label: {
                    Text("Register")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(8)
                })
                
                .alert(errorMessage,
                       isPresented: $showErrorMessage) {
                }
                
                
            } // VStack
            .background(Color.yellow)
            
        } // NavigationView
        .padding()
        .onAppear() {
            if (UserDefaults.standard.bool(forKey: kIsLoggedIn)) {
                isLoggedIn = true
            }
        }
    }
}

func isValid(email:String) -> Bool {
    guard !email.isEmpty else { return false }
    let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
    let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
    return emailValidationPredicate.evaluate(with: email)
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
