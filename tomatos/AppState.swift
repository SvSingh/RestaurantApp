//
//  AppState.swift
//  tomatos
//
//  Created by SV Singh on 2022-02-21.
//

import Foundation

class AppState: ObservableObject {
    static let shared = AppState()

    @Published var gameID = UUID()
}
