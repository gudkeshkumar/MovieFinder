//
//  Reusable.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {}

protocol StoryboardIdentifiable {
    static var identifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable {}

