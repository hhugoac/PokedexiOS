//
//  ViewController.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 09/07/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpTabs()
    }
    
    //Todo:
    // 1. Create the next items to the tabbar : Pokemon, Captures, Fav, Settings
    // 2. Setup the initial list with cards in white
    // 3. Setup the api-rest
    

    func setUpTabs() {
        let pokemonVC = PokemonListViewController()
        let capturesVC = CapturesViewController()
        let favoritesVC = FavoriteListViewController()
        let settingsVC = SettingsViewController()
        
        pokemonVC.navigationItem.largeTitleDisplayMode = .automatic
        capturesVC.navigationItem.largeTitleDisplayMode = .automatic
        favoritesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: pokemonVC)
        let nav2 = UINavigationController(rootViewController: capturesVC)
        let nav3 = UINavigationController(rootViewController: favoritesVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        let pokemonIcon = UIImage(named:"Pokemon")?.resized(to: CGSize(width: 32, height: 40))
        
        nav1.tabBarItem =  UITabBarItem(title: "Pokemon",
                                        image: pokemonIcon,
                                        tag: 1)
        
        nav2.tabBarItem =  UITabBarItem(title: "Captures", image: UIImage(systemName: "person"), tag: 2)
        nav3.tabBarItem =  UITabBarItem(title: "Favorites", image: UIImage(systemName: "person"), tag: 3)
        nav4.tabBarItem =  UITabBarItem(title: "Settings", image: UIImage(systemName: "person"), tag: 4)
        
        for nav in [nav1,nav2,nav3,nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1,nav2,nav3,nav4],
            animated: true
        )
    }
}

