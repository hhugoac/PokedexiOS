//
//  PokemonListViewController.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 09/07/24.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Pokemon"
        // Do any additional setup after loading the view.
        viewModel.fetchPokemonList()
    }


}
