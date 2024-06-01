import Foundation
import Firebase
import GoogleSignIn

#if canImport(UIKit)
    import UIKit
#endif

enum AuthenticationError: Error {
    case noFirebaseClientID
    case noRootViewController
    case googleSignInFailed(Error)
    case unexpectedError
    case notSupportedOnThisPlatform
}
struct Authentication {
    func googleOauth() async throws { // Return the Firebase user
        #if canImport(UIKit)
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthenticationError.noFirebaseClientID
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = await windowScene.windows.first?.rootViewController else {
            throw AuthenticationError.noRootViewController
        }

        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            guard let idToken = result.user.idToken?.tokenString else {
                throw AuthenticationError.unexpectedError
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            let authResult = try await Auth.auth().signIn(with: credential)
        } catch {
            throw AuthenticationError.googleSignInFailed(error)
        }
        #else
        throw AuthenticationError.notSupportedOnThisPlatform
        #endif
    }

    func logout() async throws {
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }
}


extension String: Error {}
