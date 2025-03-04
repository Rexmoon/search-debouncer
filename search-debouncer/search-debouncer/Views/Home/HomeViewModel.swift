//
//  HomeViewModel.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/19/25.
//

import Combine
import Foundation

private enum Constants {
    static let debounceDelay: Double = 0.5
}

protocol HomeViewModelRepresentable: ObservableObject {
    var isLoading: Bool { get }
    var searchText: String { get set }
    var characters: [CharacterModel] { get }
    var shouldShowEmptyView: Bool { get }
}

final class HomeViewModel<R: AppRouter> {
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var characters: [CharacterModel] = []
    
    var shouldShowEmptyView: Bool {
        characters.isEmpty
    }
    
    private var canSearch: Bool {
        !searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }
    
    private var anyCancellable: AnyCancellable?

    private let router: R
    private let characterStore: CharacterStore

    init(
        router: R,
        characterStore: CharacterStore = NetworkManager()
    ) {
        self.router = router
        self.characterStore = characterStore
        setupSearchTextDebounce()
    }
    
    private func setupSearchTextDebounce() {
        anyCancellable = $searchText
            .debounce(for: .seconds(Constants.debounceDelay),
                      scheduler: RunLoop.main)
            .sink { [weak self] text in
                guard let self else { return }
                filterCharacters(by: text)
            }
    }
    
    private func filterCharacters(by text: String) {
        guard canSearch else { return }
        debugPrint("Filtering by: \(text)")
        isLoading = true
        characters = []
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                characters = try await characterStore.filterCharacters(by: text)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: - Representable

extension HomeViewModel: HomeViewModelRepresentable { }
