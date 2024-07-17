//
//  PokemonListViewController.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 09/07/24.
//

import UIKit

class PokemonListViewController: UIViewController, PokemonListViewDelegate {

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

    // MARK: - PokemonListViewDelegate
    
    func pokemonListView(_ pokemonListVie: PokemonListView, didSelectedPokemon pokemon: Pokemon) {
        //let viewModel =
        print(String(describing: pokemon))
        let detailVC = PokemonDetailViewController()
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
