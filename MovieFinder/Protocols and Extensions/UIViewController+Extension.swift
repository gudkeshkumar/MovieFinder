//
//  UIViewController+Extension.swift
//  MovieFinder
//
//  Created by apple on 06/04/21.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    static func loadFromNib() -> Self {
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

enum Storyboard: String {
    case main = "Main"
}

extension UIViewController {
    static func instantiate<T: UIViewController>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: self.identifier) as? T else {
            fatalError("Storyboard ID is not same as \(self.identifier)")
        }
        return viewController
    }
}
