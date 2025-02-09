//
//  search_debouncerApp.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

@main
struct search_debouncerApp: App {
    @StateObject private var appCoordinator: AppCoordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appCoordinator)
        }
    }
}
