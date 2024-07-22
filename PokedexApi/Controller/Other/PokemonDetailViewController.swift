//
//  PokemonDetailViewController.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 17/07/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    private let viewModel: PokemonDetailViewModel
    private let detailView: PokemonDetailView
    
    // MARK: - Initializer
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        self.detailView = PokemonDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon"
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        addConstraints()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        
    }

    @objc
    func didTapShare() {
        //TODO: share pokemon info
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
}

// MARK: - CollectionView

extension PokemonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .description:
            return 1
        case .stats:
            return 1
        case .evolutions:
            return 1
        case .sprites:
            return 1
        case .abilities:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PokemonPhotoCollectionViewCell.identifier,
                for: indexPath
            ) as? PokemonPhotoCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            cell.configure(with: viewModel)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PokemonPhotoCollectionViewCell.identifier,
                for: indexPath
            ) as? PokemonPhotoCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            return cell
        }
    }
}
