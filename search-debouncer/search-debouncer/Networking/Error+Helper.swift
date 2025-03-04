//
//  Error+Helper.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/10/25.
//

import Foundation

enum ErrorHelper: Error {
    case url
    case network
    case notFound
    case decoding
    case encoding
    case request
    case generic(Error)
    
    var localizedDescription: String {
        switch self {
            case .url: "URL error"
            case .network: "Network error"
            case .notFound: "Not found"
            case .decoding: "Decoding error"
            case .encoding: "Encoding error"
            case .request: "Request error"
            case .generic(let error): "Generic error: \(error.localizedDescription)"
        }
    }
}
