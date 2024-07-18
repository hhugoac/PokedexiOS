//
//  PokemonDetailView.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 17/07/24.
//

import UIKit

final class PokemonDetailView: UIView {

    private var collectionView: UICollectionView?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemCyan
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.widthAnchor.constraint(equalToConstant: 100),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }
    
    private func createSection(for  sectionIndex: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
        ))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(150)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
