//
//  AppCoordinator.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

final class AppCoordinator {
    @Published var navigationPath: NavigationPath = .init()
    
    private var homeView: some View {
        let viewModel = HomeViewModel(router: self)
        return HomeView(viewModel: viewModel)
    }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {
    func build(route: AppTransition) -> some View {
        switch route {
            case .home: homeView
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
