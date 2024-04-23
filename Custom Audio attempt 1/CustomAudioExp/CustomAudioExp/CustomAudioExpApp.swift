import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

@main
struct CustomAudioExpApp: App {
    
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
    @StateObject private var matcher = Matcher()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(matcher)
                .onAppear {
                    // Ensure Firebase is initialized
                    if FirebaseApp.app() != nil {
                        matcher.fetchRecipes()
                    } else {
                        print("Firebase is not ready.")
                    }
                }
        }
    }
}

