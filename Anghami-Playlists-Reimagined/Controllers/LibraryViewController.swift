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
    
    var pageVC: LibraryPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPages" {
            pageVC = segue.destination as? LibraryPageViewController
            pageVC?.delegate = self
        }
    }

}

extension LibraryViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let next = pendingViewControllers.first as? MusicViewController {
            segmentedControl.selectedSegmentIndex = next.listIndex
        }
    }
}
