//
//  HomeView.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import SwiftUI

struct HomeView: View {
    @State private var characterList: [CharacterModel] = []
    
    private let characterStore: CharacterStore = NetworkManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(characterList) { character in
                    Text(character.name)
                }
            }
            .navigationTitle("Home")
            .task {
                do {
                    characterList = try await characterStore.filterCharacters(by: "Rick")
                } catch {
                    debugPrint("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
