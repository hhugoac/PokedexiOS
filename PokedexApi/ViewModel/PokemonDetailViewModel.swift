//
//  PokemonDetailViewModel.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 18/07/24.
//

import UIKit

final class PokemonDetailViewModel {
    
    private let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    private var requestUrl: URL? {
        return URL(string: pokemon.url)
    }
    
    var title: String {
        return pokemon.name.uppercased()
    }
    
}
