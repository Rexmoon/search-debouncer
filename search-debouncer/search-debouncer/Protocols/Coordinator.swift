//
//  Coordinator.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype Route
    associatedtype AssociatedView: View
    
    func build(route: Route) -> AssociatedView
}
