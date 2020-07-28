//
//  ChildViewControllerExtension.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/28/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
