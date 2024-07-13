//
//  GetAllPokemonResponse.swift
//  PokedexApi
//
//  Created by Hugo Alonzo on 13/07/24.
//

import Foundation

struct GetAllPokemonResponse: Codable {
    
    let count: Int
    let next: String?
    let prev: String?
    let results: [Pokemon]
}



