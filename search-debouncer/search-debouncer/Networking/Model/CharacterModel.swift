//
//  CharacterModel.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/10/25.
//

import Foundation

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String?
}

// MARK: - Identifiable

extension CharacterModel: Identifiable { }
