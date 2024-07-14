//
//  PokemonListViewModel.swift
//  PokedexApi
//
//  Created by Hugo Alonzo on 13/07/24.
//

import UIKit

protocol PokemonListViewModelDelegate: AnyObject {
    func didLoadInitialPokemonList()
}

final class PokemonListViewModel : NSObject {
    
    public weak var delegate: PokemonListViewModelDelegate?
    private var pokemons: [Pokemon] = []
    
    public func fetchPokemonList() {
        Service.shared.execute(
            .init(endpoint: .pokemon), 
            expecting: GetAllPokemonResponse.self) {
            [weak self] result in
            switch result {
            case .success(let data):
                let results = data.results
                self?.pokemons = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialPokemonList()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension PokemonListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("😇 \(pokemons.count)")
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? UICollectionViewCell else {
            fatalError("Unsuported cell")
        }
        cell.backgroundColor = .blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2

        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
