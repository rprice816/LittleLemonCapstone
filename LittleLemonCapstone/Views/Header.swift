//
//  Header.swift
//  LittleLemonCapstone
//
//  Created by russell price on 7/22/23.
//

import SwiftUI

struct Header: View {
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    HStack {
                        if isLoggedIn {
                            NavigationLink(destination: UserProfile()) {
                                Image("profile")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(maxHeight: 40)
                                    .clipShape(Circle())
                                    .padding(.leading)
                            }
                        }
                        Spacer()
                        Image("logo")
                        Spacer()
                        Image(systemName: "cart")
                            .foregroundColor(.primaryColor1)
                            .padding(.trailing)
                    }
                }
            }
        }
        .frame(maxHeight: 50)
        .onAppear() {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
