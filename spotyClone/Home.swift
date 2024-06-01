//
//  Home.swift
//  spotyClone
//
//  Created by Anderson Gil on 31/5/24.
//

import SwiftUI
import Firebase
import AudioToolbox

struct Home: View {
    @State private var err : String = ""
    @State private var loginModel = LoginViewModel()
    
    private var soundID: SystemSoundID = 0
    init() {
        if let soundUrl = Bundle.main.url(forResource: "mario-slide", withExtension: "mp3") { // Adjust file name and extension
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundID)
        }
    }
    

    var body: some View {
        HStack {
            Image(systemName: "hand.wave.fill")
            if ((Auth.auth().currentUser) != nil){
                Text(
                    "Hello " +
                    (Auth.auth().currentUser!.displayName ?? "Username not found")
                )
            }

        }
        .onAppear {
            AudioServicesPlaySystemSound(soundID)
        }
        .onDisappear {  // Cleanup when view disappears
            AudioServicesDisposeSystemSoundID(soundID)
        }
        Button{
            Task {
                do {
                    try await Authentication().logout()
                    loginModel.mockAuth.toggle()
                } catch let e {
                    err = e.localizedDescription
                }
            }
        }label: {
            Text("Log Out").padding(8)
        }.buttonStyle(.borderedProminent)
        
        Text(err).foregroundColor(.red).font(.caption)
    }

}


#Preview {
    Home()
}
