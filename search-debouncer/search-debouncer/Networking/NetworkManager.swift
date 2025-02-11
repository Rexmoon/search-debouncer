//
//  NetworkManager.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import Foundation

private enum Constants {
    static let scheme: String = "https"
    static let host: String = "https://rickandmortyapi.com/api"
}

actor NetworkManager {
    
    // MARK: - Properties
    
    private lazy var urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    private let urlSession: URLSession
    
    // MARK: - Initializers
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    private func makeQueryItems(from parameters: [String: Any]) -> [URLQueryItem] {
        parameters.compactMap {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
    }
    
    // MARK: - Get data
    
    private func getData(from endpoint: String,
                         with parameters: [String: Any]) async throws -> Data {
        urlComponents.queryItems = makeQueryItems(from: parameters)
        
        guard let url = urlComponents.url
        else { throw ErrorHelper.url }
        
        do {
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw ErrorHelper.request }
            
            return data
        } catch {
            throw error
        }
    }
}
