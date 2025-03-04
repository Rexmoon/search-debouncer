//
//  CharacaterStore.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/10/25.
//

import Foundation

protocol CharacterStore {
    func filterCharacters(by name: String) async throws -> [CharacterModel]
}

// MARK: Character store

extension NetworkManager: CharacterStore {
    func filterCharacters(by name: String) async throws -> [CharacterModel] {
        let parameters: [String: Any] = [
            "name": name
        ]
        
        do {
            let data = try await getData(from: "/character", with: parameters)
            let response = try JSONDecoder().decode(APIResponse<CharacterModel>.self, from: data)
            return response.results
        } catch {
            throw error
        }
    }
}
