//
//  UIImage+Extensions.swift
//  PokedexApi
//
//  Created by Hector Alonzo  on 11/07/24.
//

import UIKit
extension UIImage{
    func resized(to size: CGSize) -> UIImage{
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
