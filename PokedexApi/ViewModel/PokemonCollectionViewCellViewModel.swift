//
//  PokemonCollectionViewCellViewModel.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 15/07/24.
//

import Foundation

final class PokemonCollectionViewCellViewModel: Hashable, Equatable {
    
    public let pokemonName: String
    private let pokemonImageUrl: URL?
    private static let imageBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    static func == (lhs: PokemonCollectionViewCellViewModel, rhs: PokemonCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pokemonName)
        hasher.combine(pokemonImageUrl)
    }
    
    // MARK: - Init
    init(
        pokemonName: String,
        pokemonImageUrl: URL?
    ) {
        self.pokemonName = pokemonName
        self.pokemonImageUrl = pokemonImageUrl
    }
    
    private var computedUrl: String = {
        
        let string = imageBaseUrl
        return string
    }()
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = pokemonImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        pokemonImageUrl
        let request = URLRequest(url: url)
        let task =  URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
