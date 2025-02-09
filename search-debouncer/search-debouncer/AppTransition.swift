//
//  AppTransition.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

enum AppTransition {
    case home
    
    var identifier: String {
        switch self {
            case .home:
                "Show home"
        }
    }
}
