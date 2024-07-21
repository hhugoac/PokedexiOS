//
//  PokemonListView.swift
//  PokedexApi
//
//  Created by Hugo Alonzo on 13/07/24.
//

import UIKit

protocol PokemonListViewDelegate: AnyObject {
    func pokemonListView(
        _ pokemonListView: PokemonListView,
        didSelectedPokemon pokemon: Pokemon
    )
}

/// View that handles showing list of pokemons and a loading ...
class PokemonListView: UIView {
 
    private let viewModel = PokemonListViewModel()
    public weak var delegate: PokemonListViewDelegate?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PokemonCollectionViewCell.self,
                                forCellWithReuseIdentifier: PokemonCollectionViewCell.collectionIdentifier)
        collectionView.register(FooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(spinner, collectionView)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        setupCollectionView()
        viewModel.fetchPokemonList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported view")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension PokemonListView: PokemonListViewModelDelegate {
    func didLoadInitialPokemonList() {
        spinner.stopAnimating()
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMorePokemons(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectPokemon(_ pokemon: Pokemon) {
        print(String(describing: pokemon))
        delegate?.pokemonListView(self, didSelectedPokemon: pokemon)
    }
}
