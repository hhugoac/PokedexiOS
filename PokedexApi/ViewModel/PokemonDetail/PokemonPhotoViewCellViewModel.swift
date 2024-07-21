//
//  PokemonPhotoViewCellViewModel.swift
//  PokedexApi
//
//  Created by Hugo Alonzo on 21/07/24.
//

import Foundation

class PokemonPhotoViewCellViewModel {
    
    private let pokemonImageUrl: URL?
    private let imageBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    
    init(pokemonImageUrl: URL?) {
        self.pokemonImageUrl = pokemonImageUrl
    }
    
    private var pokemonId: String? {
        if let url = pokemonImageUrl?.absoluteString {
            let components = url.split(separator: "/")
            if components.count >= 6 {
                return String(components[5])
            }
        }
        return nil
    }
    
    private var imageUrl: URL? {
        return URL(string:"\(imageBaseUrl)\(pokemonId ?? "").png")
    }
    
    public func downloadImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
