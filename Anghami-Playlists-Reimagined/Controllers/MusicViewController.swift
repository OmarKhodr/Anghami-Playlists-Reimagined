//
//  ViewController.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/7/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: TableViewDataSource<Item>?
    
    var listIndex: Int!
    var requestURL: String!
    
    var items: [Item] = []
    let anghami = AnghamiManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.rowHeight = 80.0
        tableView.register(UINib(nibName: K.itemCellNibName, bundle: nil), forCellReuseIdentifier: K.itemReusableCellIdentifier)
        
        anghami.delegate = self
        
        anghami.performRequest(with: requestURL, type: RequestType(rawValue: listIndex)!)
    }


}

extension MusicViewController: AnghamiManagerDelegate {
    
    func didFailWithError(_ manager: AnghamiManager, _ error: Error) {
        print(error)
    }

    func didGetItems(_ manager: AnghamiManager, _ items: [Item], _ type: RequestType) {
        for item in items {
            if type == .Playlists && item.title == "Likes" || item.title == "Downloads" {
                self.items.insert(item, at: 0)
            } else {
                self.items.append(item)
            }
        }
        if type == .Albums || type == .Artists {
            self.items.sort { (item1, item2) -> Bool in
                return item1.title < item2.title
            }
        }
        dataSource = .make(for: self.items, reuseIdentifier: K.itemReusableCellIdentifier)
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}

extension MusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
