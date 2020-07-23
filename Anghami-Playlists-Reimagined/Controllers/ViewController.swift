//
//  ViewController.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/7/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class PlayListsViewController: UIViewController {
    
    let anghami = AnghamiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        anghami.performRequest(with: "https://bus.anghami.com/public/user/playlists")
    }


}

extension PlayListsViewController: AnghamiManagerDelegate {
    
}
