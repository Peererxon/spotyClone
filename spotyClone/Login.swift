//
//  Login.swift
//  spotyClone
//
//  Created by Anderson Gil on 31/5/24.
//

import SwiftUI

struct Login: View {
    @State private var err : String = ""
    
    @EnvironmentObject var loginModel: LoginViewModel;
    
    var body: some View {
        VStack {
            
            Spacer()
            TextField(
                "Email",
                text: $loginModel.email
                    
            )
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .padding(.top,20)
            
            Divider()
            
            SecureField("Password", text: $loginModel.password)
                .padding(.top,20)
            
            Divider()
            
            Spacer()
            
            Button (action: loginModel.Login, label: {
                
                Label("Login with email", systemImage: "lock")
            })
                
            
            
            
            Button{
                Task {
                    do {
                        try await Authentication().googleOauth()
                    } catch let e {
                        print(e)
                        err = e.localizedDescription
                    }
                }
            }label: {
                HStack {
                    Image(systemName: "person.badge.key.fill")
                    Text("Sign in with Google")
                }.padding(8)
            }.buttonStyle(.borderedProminent)
            
            Text(err).foregroundColor(.red).font(.caption)
        }
    }
}

#Preview {
    Login()
}
