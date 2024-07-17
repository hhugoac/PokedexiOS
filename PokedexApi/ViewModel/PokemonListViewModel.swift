//
//  PokemonListViewModel.swift
//  PokedexApi
//
//  Created by Hugo Alonzo on 13/07/24.
//

import UIKit

protocol PokemonListViewModelDelegate: AnyObject {
    func didLoadInitialPokemonList()
    func didLoadMorePokemons(with newIndexPaths: [IndexPath])
    func didSelectPokemon(_ pokemon: Pokemon)
}

final class PokemonListViewModel : NSObject {
    
    public weak var delegate: PokemonListViewModelDelegate?
    
    private var pokemons: [Pokemon] = [] {
        didSet {
            for pokemon in pokemons {
                let viewModel = PokemonCollectionViewCellViewModel(
                    pokemonName: pokemon.name,
                    pokemonImageUrl: URL(string: pokemon.url)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [PokemonCollectionViewCellViewModel] = []
    private var next: String? = nil
    
    private var  isLoadingMorePokemons: Bool = false
    
    /// Fetch initial set of pokemons (20)
    public func fetchPokemonList() {
        Service.shared.execute(
            .listPokemonsRequest,
            expecting: GetAllPokemonResponse.self) {
            [weak self] result in
            switch result {
            case .success(let data):
                let results = data.results
                self?.pokemons = results
                self?.next = data.next
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialPokemonList()
                }
            case .failure(let error):
                print("FAILURE: " + String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMorePokemons else {
            return
        }
        
        isLoadingMorePokemons = true
        guard let request = Request(url: url) else {
            isLoadingMorePokemons = false
            return
        }
        Service.shared.execute(request, expecting: GetAllPokemonResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let next = responseModel.next
                
                strongSelf.next = next
                
                let originalCount = strongSelf.pokemons.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.pokemons.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMorePokemons(
                        with: indexPathsToAdd
                    )
                    strongSelf.isLoadingMorePokemons = false
                }
            case .failure(let error):
                print("FAILURE: " + String(describing: error))
                strongSelf.isLoadingMorePokemons = false
            }
        }
    }
    
    public var shouldShowMoreIndicator: Bool {
        return next != nil
    }
}

extension PokemonListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonCollectionViewCell.collectionIdentifier,
            for: indexPath
        ) as? PokemonCollectionViewCell else {
            fatalError("Unsuported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
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

extension PokemonListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowMoreIndicator,
              !isLoadingMorePokemons,
              !cellViewModels.isEmpty,
              let next = next,
              let url = URL(string: next) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewHeight) {
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
