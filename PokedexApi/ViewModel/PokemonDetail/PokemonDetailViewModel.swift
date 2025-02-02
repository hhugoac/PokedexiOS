//
//  PokemonDetailViewModel.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 18/07/24.
//

import UIKit

final class PokemonDetailViewModel {
    
    private let pokemon: Pokemon
    
    enum SectionType {
        case photo(viewModel: PokemonPhotoViewCellViewModel)
        case description
        case stats
        case evolutions
        case sprites
        case abilities
    }
    
    public var sections: [SectionType] = []
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: .init(pokemonImageUrl: requestUrl)),
            .description,
            .description,
            .stats,
            .stats
        ]
    }
    
    private var requestUrl: URL? {
        return URL(string: pokemon.url)
    }
    
    var title: String {
        return pokemon.name.uppercased()
    }
    
    // MARK: Layouts
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                        NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createDescriptionSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                        NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(0.5),
                            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createStatusSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize:
                        NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}
