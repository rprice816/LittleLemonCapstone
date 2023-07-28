//
//  Onboarding.swift
//  LittleLemonCapstone
//
//  Created by russell price on 7/22/23.
//


import SwiftUI

struct Onboarding: View {
    @StateObject private var viewModel = ViewModel()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    
    @State var isKeyboardVisible = false
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Rectangle()
                    .fill(Color.highlightColor1)
                    .ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Spacer()
                        Image("logo")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 100)
                            .clipped()
                        
                        Text("Sign Up")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundColor(.primaryColor1)
                        VStack {
                            NavigationLink(destination: Home(), isActive: $isLoggedIn) { }
                            Text("First Name")
                                .foregroundColor(.primaryColor1)
                                .fontWeight(.medium)
                            TextField("First Name", text: $firstName)
                                .frame(width: 325, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                            Text("Last Name")
                                .foregroundColor(.primaryColor1)
                                .fontWeight(.medium)
                            TextField("Last Name", text: $lastName)
                                .frame(width: 325, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                            Text("Email")
                                .foregroundColor(.primaryColor1)
                                .fontWeight(.medium)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .frame(width: 325, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .disableAutocorrection(true)
                        .padding()
                        
                        if viewModel.errorMessageShow {
                            withAnimation() {
                                Text(viewModel.errorMessage)
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                            }
                        }
                        
                        Button("Register") {
                            if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                                UserDefaults.standard.set(firstName, forKey: kFirstName)
                                UserDefaults.standard.set(lastName, forKey: kLastName)
                                UserDefaults.standard.set(email, forKey: kEmail)
                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                UserDefaults.standard.set(true, forKey: kOrderStatuses)
                                UserDefaults.standard.set(true, forKey: kPasswordChanges)
                                UserDefaults.standard.set(true, forKey: kSpecialOffers)
                                UserDefaults.standard.set(true, forKey: kNewsletter)
                                firstName = ""
                                lastName = ""
                                email = ""
                                isLoggedIn = true
                            }
                        }
                        .buttonStyle(ButtonStyleYellowColorWide())
                        Spacer()
                    }
                }
                .onAppear() {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
