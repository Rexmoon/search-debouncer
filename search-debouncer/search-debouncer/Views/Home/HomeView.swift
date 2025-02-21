//
//  HomeView.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelRepresentable>: View {
    @State private var searchText: String = ""
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.shouldShowEmptyView {
                    emptyView
                } else {
                    List(viewModel.characters) { character in
                        Text(character.name)
                    }
                }
            }
            .navigationTitle("Home")
            .searchable(text: $viewModel.searchText)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }
    
    private var emptyView: some View {
        Text("No results found")
    }
}

#Preview {
    let app = AppCoordinator()
    let viewModel = HomeViewModel(router: app)
    HomeView(viewModel: viewModel)
}
