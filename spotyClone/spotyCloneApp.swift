//
//  spotyCloneApp.swift
//  spotyClone
//
//  Created by Anderson Gil on 30/5/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct spotyCloneApp: App {
    
    init() {
        //firebase init
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                //Handle Google Oauth URL
                GIDSignIn.sharedInstance.handle(url)
            }
        }
    }
}
