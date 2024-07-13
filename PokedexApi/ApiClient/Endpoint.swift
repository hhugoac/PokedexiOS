//
//  Endpoint.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 11/07/24.
//

import Foundation

@frozen enum Endpoint: String {
    case pokemon = "pokemon?limit=50&offset=0"
    case detail
    case search
}
