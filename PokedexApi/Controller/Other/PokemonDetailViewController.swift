//
//  PokemonDetailViewController.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 17/07/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    
    
    // MARK: - Initializer
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))

    }

    @objc
    func didTapShare() {
        //TODO: share pokemon info
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
