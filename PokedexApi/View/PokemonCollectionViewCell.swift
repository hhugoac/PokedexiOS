//
//  PokemonCollectionViewCell.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 15/07/24.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let collectionIdentifier = "PokemonCollectionViewCell"
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(pokemonImageView, nameLabel)
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
            
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pokemonImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
        nameLabel.text = nil
    }
    
    public func configure(with viewModel: PokemonCollectionViewCellViewModel) {
        nameLabel.text = viewModel.pokemonName
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.pokemonImageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
