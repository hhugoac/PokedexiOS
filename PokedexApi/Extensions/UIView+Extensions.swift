//
//  UIView+Extensions.swift
//  PokedexApi
//
//  Created by Hugo Alonzo on 13/07/24.
//

import UIKit
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
