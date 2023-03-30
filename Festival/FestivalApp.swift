//
//  FestivalApp.swift
//  Festival
//
//  Created by Tom Sartori on 2/6/23.
//
//

import SwiftUI

@main
struct FestivalApp: App {
    init() {
        UserDefaults.standard.set(false, forKey: "isAdmin")
        UserDefaults.standard.set(nil, forKey: "token")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
