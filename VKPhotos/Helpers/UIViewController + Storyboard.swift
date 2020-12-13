//
//  UIViewController + Storyboard.swift
//  VKPhotos
//
//  Created by Игорь Дикань on 13.12.2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let trimName = name.trimmingCharacters(in: CharacterSet(charactersIn: "ViewController"))
        let storyboard = UIStoryboard(name: trimName, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: not initial view controller in \(name) storyboard")
        }
    }
}
