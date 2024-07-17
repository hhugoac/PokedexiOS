//
//  Request.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 11/07/24.
//

import Foundation

final class Request {
    private struct Constants {
        static let baseUrl = "https://pokeapi.co/api/v2"
    }
    
    /// Desired endpoint
    private let endpoint: Endpoint
    
    /// Path components for Api
    private let pathComponents: [String]
    
    /// Query components for API
    private let queryParameter: [URLQueryItem]
    
    ///  Desired http method
    private let httpMethod = "GET"
    
    /// Constructing url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        // add the endpoint to the url
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        
        if !queryParameter.isEmpty {
            string += "?"
            let argumentString = queryParameter.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    /// Computed & construct API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameter: Collection of query parameters
    init(
        endpoint: Endpoint,
        pathComponents: [String] = [],
        queryParameter: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameter = queryParameter
    }
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endPointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let pokemonEndpoint = Endpoint(rawValue: endPointString) {
                    self.init(endpoint: pokemonEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endPointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let endpoint = Endpoint(rawValue: endPointString){
                    self.init(endpoint: endpoint, queryParameter: queryItems)
                    return
                }                    
            }
        }
        return nil
    }
}

extension Request {
    static let listPokemonsRequest = Request(endpoint: .pokemonInit)
}
