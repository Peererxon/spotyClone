//
//  ContentView.swift
//  spotyClone
//
//  Created by Anderson Gil on 30/5/24.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    @StateObject private var loginViewModel = LoginViewModel()
    var body: some View {
        VStack {
            if (userLoggedIn || loginViewModel.mockAuth ) {
                        Home()
                    } else {
                        Login().environmentObject(loginViewModel)
                    }
                }.onAppear{
                    //Firebase state change listeneer
                    Auth.auth().addStateDidChangeListener{ auth, user in
                        if (user != nil) {
                            userLoggedIn = true
                        } else {
                            userLoggedIn = false
                        }
                    }
                }

    }
}

#Preview {
    ContentView()
}
