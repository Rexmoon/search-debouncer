//
//  ContentView.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $appCoordinator.navigationPath) {
            appCoordinator
                .build(route: .home)
                .navigationDestination(for: AppTransition.self) { route in
                    appCoordinator.build(route: route)
                }
        }
    }
}
