//
//  PokemonCollectionViewCell.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 15/07/24.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let collectionIdentifier = "PokemonCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "My name"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .cyan
        contentView.addSubviews(nameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported view cell")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            
        ])
    }
    
}
