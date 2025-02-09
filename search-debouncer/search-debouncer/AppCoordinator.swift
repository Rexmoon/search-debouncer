//
//  AppCoordinator.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

final class AppCoordinator {
    @Published var navigationPath: NavigationPath = .init()
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {
    func build(route: AppTransition) -> some View {
        switch route {
            case .home: HomeView()
        }
    }
}

// MARK: - Router

extension AppCoordinator: AppRouter {
    func process(route: AppTransition) {
        navigationPath.append(route)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
