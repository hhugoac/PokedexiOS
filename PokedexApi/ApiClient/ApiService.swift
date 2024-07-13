//
//  ApiService.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 11/07/24.
//

import Foundation

/// Primary API service object to get data
final class Service {
    
    /// Primary constructor
    static let shared = Service()
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: Request,
        expecting type:T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToGetData))
            return
        }
        print(String(describing: urlRequest))
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(ServiceError.failedToCreateRequest))
                return
            }
            do {
                let result =  try JSONDecoder().decode(type.self, from: data)
                print(String(describing: result))
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: - private
    private func request(from request: Request) -> URLRequest? {
        guard let url = request.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
