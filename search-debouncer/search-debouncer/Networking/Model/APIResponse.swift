//
//  APIResponse.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/10/25.
//

import Foundation

struct APIResponse<Element: Decodable>: Decodable {
    let info: Info
    let results: [Element]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
