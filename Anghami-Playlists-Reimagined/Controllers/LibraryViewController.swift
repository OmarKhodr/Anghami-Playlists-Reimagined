//
//  LibraryViewController.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/27/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var lists = [
        "https://bus.anghami.com/public/user/playlists",
        "https://bus.anghami.com/public/user/albums",
        "https://bus.anghami.com/public/user/artists"
    ]
    
    var pageVC: LibraryPageViewController?
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPages" {
            pageVC = segue.destination as? LibraryPageViewController
            pageVC?.delegate = self
        }
    }

    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        guard let pageVC = pageVC else { fatalError("pageVC not initialized!!") }
        let nextIndex = sender.selectedSegmentIndex
        let nextVC = pageVC.viewMusicController(nextIndex)
        if currentIndex > nextIndex {
            pageVC.setViewControllers([nextVC!], direction: .reverse, animated: true, completion: nil)
        } else {
            pageVC.setViewControllers([nextVC!], direction: .forward, animated: true, completion: nil)
        }
        currentIndex = nextIndex
    }
}

extension LibraryViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let next = pendingViewControllers.first as? MusicViewController {
            segmentedControl.selectedSegmentIndex = next.listIndex
            currentIndex = next.listIndex
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (!finished || !completed), let previous = previousViewControllers.first as? MusicViewController {
            segmentedControl.selectedSegmentIndex = previous.listIndex
            currentIndex = previous.listIndex
        }
    }
}
