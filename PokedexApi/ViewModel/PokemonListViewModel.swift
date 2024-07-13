//
//  PokemonListViewModel.swift
//  PokedexApi
//
//  Created by Hugo Alonzo on 13/07/24.
//

import Foundation

final class PokemonListViewModel : NSObject {
    
    private var pokemons: String = ""
    
    public func fetchPokemonList() {
        Service.shared.execute(
            .init(endpoint: .pokemon), 
            expecting: String.self) {
            [weak self] result in
            switch result {
            case .success(let data):
                print(String(describing: data))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
