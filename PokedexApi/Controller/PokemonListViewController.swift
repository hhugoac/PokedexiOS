//
//  PokemonListViewController.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 09/07/24.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let pokemonListView = PokemonListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Pokemon"
        view.addSubview(pokemonListView)
        setupView()
    }

    private func setupView() {
        NSLayoutConstraint.activate([
            pokemonListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pokemonListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

}
