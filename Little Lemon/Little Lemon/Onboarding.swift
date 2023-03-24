//
//  Onboarding.swift
//  LittleLemonCapstone
//  By: S.Mayer


import SwiftUI

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    //@State private var firstName = ""
    //@State private var lastName = ""
    //@State private var email = ""
    // change property wrapper to update view upon value change
    @AppStorage(kFirstName) var firstName = ""
    @AppStorage(kLastName) var lastName = ""
    @AppStorage(kEmail) var email = ""
   
    @State private var errorMessage:String = "First name, Last name, and email are required fields"
    @State private var showErrorMessage: Bool = false
    
    @State private var isLoggedIn = false
    
    var body: some View {
        
        ZStack {
            Image("logo")
                .resizable()
                .frame(width:200, height:40, alignment:.leading)
                .aspectRatio(1.0, contentMode: .fit)
                .padding(.bottom, 6)
            
            if (isLoggedIn) {
                HStack {
                    Spacer()
                    Image("profile-image-placeholder")
                        .resizable()
                        .frame(width:40, height:40, alignment:.leading)
                        .aspectRatio(1.0, contentMode: .fit)
                        .clipShape(Circle())
                        .padding(.trailing, 20)
                        .padding(.bottom, 6)
                }
            }
        }  // ZStack
        
        NavigationView {
            
            VStack(alignment: .leading)  {
                
                // Replacing this with NavigationStack and NavigationDestination(isPresented) doesn't consistently work for some reason, so I will keep this old way of navigation for now. I've seen a value of true for isPresented but the code just steps over that line in the Debugger instead of presenting.
                NavigationLink(destination: Home(),isActive: $isLoggedIn) {
                    // empty view here since nav is
                    // is activated by button setting
                    // isLoggedIn to true
                    EmptyView()
                }
                
                ScrollView {
                    VStack() {
                        Hero()
                    }
                    
                    VStack(alignment: .leading) {
                        
                        // First name entry
                        Text("First name *")
                            .font(.body)
                            .padding([.leading, .top], 20)
                            .foregroundColor(Color.gray)
                            .fontWeight(.bold)
                        
                        TextField("First Name",
                                  text: $firstName)
                        .padding([.leading, .trailing], 20)
                        .textFieldStyle(.roundedBorder)
                        
                        // Last name entry
                        Text("Last name *")
                            .font(.body)
                            .padding([.leading, .top], 20)
                            .foregroundColor(Color.gray)
                            .fontWeight(.bold)
                        
                        TextField("Last Name",
                                  text: $lastName
                        )
                        .padding([.leading, .trailing,], 20)
                        .textFieldStyle(.roundedBorder)
                        
                        // email entry
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
                    }
                    
                }
                // Scrollview
                
                Spacer()
                
                Button(action:
                    verifyInputFields,
                       label: {
                    Text("Register")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.llGreen)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 10)
                        .padding(.bottom, 60 )
                })
                
                .alert(errorMessage,
                       isPresented: $showErrorMessage) {
                }
                
                
            } // outer VStack
            .background(Color.white)
            
            
        } // NavigationView
        .onAppear() {
            if (UserDefaults.standard.bool(forKey: kIsLoggedIn)) {
                isLoggedIn = true
            }
            else {
                isLoggedIn = false
            }
            
            // onAppear doesn't get called when navLink pops back here, so we cannot clear firstName, etc
            // after a log out. By using AppStorage instead of State
            // property wrapper, the view is updated when the values change.
            
            //firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
            //lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
            //email = UserDefaults.standard.string(forKey: kEmail) ?? ""
           
        }
    }
    
    func verifyInputFields()
    {
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
