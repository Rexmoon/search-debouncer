//
//  Router.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

protocol Router {
    associatedtype Route
    
    var navigationPath: NavigationPath { get set }
    
    func process(route: Route)
    func pop()
    func popToRoot()
}

protocol AppRouter: Router where Route == AppTransition { }
