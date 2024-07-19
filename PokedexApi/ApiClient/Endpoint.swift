//
//  Endpoint.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 11/07/24.
//

import Foundation

@frozen enum Endpoint: String {
    case pokemonInit = "pokemon?limit=20&offset=0"
    case pokemon
    case detail
    case search
}
