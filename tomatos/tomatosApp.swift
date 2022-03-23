//
//  tomatosApp.swift
//  tomatos
//
//  Created by SV Singh on 2021-11-30.
//

import SwiftUI
@main
struct tomatosApp: App {
    @StateObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            LoginView().id(appState.gameID)
        }
    }
}
