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
    private let imageBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
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
    
    private var pokemonId: String? {
        if let url = pokemonImageUrl?.absoluteString {
            let components = url.split(separator: "/")
            print(String(describing: components))
            if components.count >= 6 {
                return String(components[5])
            }
        }
        return nil
    }
    
    private var imageUrl: URL? {
        return URL(string:"\(imageBaseUrl)\(pokemonId ?? "").png")
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
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
