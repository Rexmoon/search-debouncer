//
//  NetworkManager.swift
//  search-debouncer
//
//  Created by Jose Luna on 2/9/25.
//

import Foundation

private enum Constants {
    static let scheme: String = "https"
    static let host: String = "rickandmortyapi.com"
    static let basePath: String = "/api"
}

final class NetworkManager {
    
    // MARK: - Properties
    private let urlSession: URLSession
    
    // MARK: - Initializers
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    private func makeQueryItems(from parameters: [String: Any]) -> [URLQueryItem] {
        parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
    
    // MARK: - Get data
    func getData(from endpoint: String,
                 with parameters: [String: Any]) async throws -> Data {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = "\(Constants.basePath)\(endpoint)"
        urlComponents.queryItems = makeQueryItems(from: parameters)
        
        guard let url = urlComponents.url else { throw ErrorHelper.url }
        
        do {
            let (data, response) = try await urlSession.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw ErrorHelper.request }
            
            return data
        } catch {
            throw error
        }
    }
}
