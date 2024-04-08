//
//  CustomAudioExpApp.swift
//  CustomAudioExp
//
//  Created by Mihail Bogdanov on 10/03/2024.
//

import SwiftUI

@main
struct CustomAudioExpApp: App {
    
    @StateObject private var matcher = Matcher()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(matcher)
        }
    }
}
