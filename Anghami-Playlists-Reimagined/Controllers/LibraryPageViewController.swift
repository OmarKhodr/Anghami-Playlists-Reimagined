//
//  LibraryPageViewController.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/27/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class LibraryPageViewController: UIPageViewController {
    var lists = [
        "https://bus.anghami.com/public/user/playlists",
        "https://bus.anghami.com/public/user/albums",
        "https://bus.anghami.com/public/user/artists"
    ]
    var savedVCs = [MusicViewController?](repeating: nil, count: 3)
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentIndex = 0
        if let viewController = viewMusicController(currentIndex) {
            let viewControllers = [viewController]
            
            // 2
            setViewControllers(viewControllers,
                               direction: .forward,
                               animated: false,
                               completion: nil)
            dataSource = self
        }
    }
    
    func viewMusicController(_ index: Int) -> MusicViewController? {
        if let saved = savedVCs[index] {
            return saved
        } else {
            guard
                let storyboard = storyboard,
                let page = storyboard
                    .instantiateViewController(withIdentifier: "MusicViewController")
                    as? MusicViewController
                else {
                    return nil
            }
            page.requestURL = lists[index]
            page.listIndex = index
            savedVCs[index] = page
            return page
        }
    }
}

extension LibraryPageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController)
        -> UIViewController? {
            if let viewController = viewController as? MusicViewController,
                let index = viewController.listIndex,
                index > 0 {
                currentIndex = index-1
                return viewMusicController(index - 1)
            }
            
            return nil
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController)
        -> UIViewController? {
            if let viewController = viewController as? MusicViewController,
                let index = viewController.listIndex,
                (index + 1) < lists.count {
                currentIndex = index+1
                return viewMusicController(index + 1)
            }
            
            return nil
    }
}
