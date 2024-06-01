//
//  LoginViewModel.swift
//  spotyClone
//
//  Created by Anderson Gil on 31/5/24.
//

import SwiftUI
import Firebase

class LoginViewModel : ObservableObject {
    
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var mockAuth : Bool = false
    func Login(){
        print("\(email) user Logged with Email method!")
        mockAuth.toggle()
    }
}
