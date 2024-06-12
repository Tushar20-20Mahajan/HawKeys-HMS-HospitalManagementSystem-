//
//  AdminProfile.swift
//  HawKeys-HMS
//
//  Created by Akshay Jha on 12/06/24.
//

import SwiftUI

struct AdminProfile: View {
    @State private var isLoggedOut = false
    var body: some View {
        VStack{
            Button(action: {
                logout()
            }) {
                Text("Logout")
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .fullScreenCover(isPresented: $isLoggedOut) {
            userSignIn()
        }
    }
    private func logout() {
        // Clear all data stored in UserDefaults
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "firstName")
        defaults.removeObject(forKey: "lastName")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "age")
        defaults.removeObject(forKey: "gender")
        defaults.removeObject(forKey: "bloodGroup")
        defaults.removeObject(forKey: "height")
        defaults.removeObject(forKey: "weight")
        defaults.removeObject(forKey: "authToken")
        defaults.removeObject(forKey: "userType")
        defaults.removeObject(forKey: "authToken")
        
        // Set isLoggedOut to true to trigger the navigation to sign-in screen
        isLoggedOut = true
    }
}

#Preview {
    AdminProfile()
}
