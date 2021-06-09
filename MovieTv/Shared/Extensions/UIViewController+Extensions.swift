//
//  UIViewController+Extensions.swift
//  MovieTv
//
//  Created by Asraful Alam on 9/6/21.
//

import UIKit

extension UIViewController {
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}


