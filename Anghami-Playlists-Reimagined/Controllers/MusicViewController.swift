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
    var selectedItem: Item!
    
    var items: [Item] = []
    let anghami = AnghamiManager()
    
    private let loadingVC = LoadingViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.rowHeight = 80.0
        tableView.register(UINib(nibName: K.itemCellNibName, bundle: nil), forCellReuseIdentifier: K.itemReusableCellIdentifier)
        
        anghami.delegate = self
        
        add(loadingVC)
        anghami.performRequest(with: requestURL, type: RequestType(rawValue: listIndex)!)
    }

}

extension MusicViewController: AnghamiManagerDelegate {
    
    func didFailWithError(_ manager: AnghamiManager, _ error: Error) {
        print(error)
    }

    func didGetItems(_ manager: AnghamiManager, _ items: [Item], _ type: RequestType) {
        DispatchQueue.main.async {
            self.loadingVC.remove()
        }
        for item in items {
            if type == .Playlists && item.title == "Likes".localized || item.title == "Downloads".localized {
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

enum Segues: String {
    case ToItem = "ToItem"
}

extension MusicViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //i.e. if cell is that of an artist
        if listIndex == 2 { return }

        selectedItem = items[indexPath.row]
        performSegue(withIdentifier: "ToItem", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToItem.rawValue {
            let destinationVC = segue.destination as! ItemDetailViewController
            let currType = RequestType(rawValue: listIndex)!
            switch currType {
            case .Playlists:
                destinationVC.requestType = .Playlist
                if selectedItem.title == "Likes" || selectedItem.title == "Downloads" {
                    destinationVC.coverArt = K.coverArtDict[K.nameDict[selectedItem.title]!]!
                } else {
                    destinationVC.coverArt = K.Colors.playlistCoverArt
                }
                destinationVC.itemArtist = ""
                destinationVC.itemNumSongs = selectedItem.subtitle.uppercased()
            case .Albums:
                destinationVC.requestType = .Album
                destinationVC.coverArt = K.Colors.albumCoverArt
                destinationVC.itemArtist = selectedItem.subtitle
                destinationVC.itemNumSongs = ""
                destinationVC.itemYear = selectedItem.year
                
            default:
                break
            }
            destinationVC.itemTitle = selectedItem.title
            destinationVC.itemID = selectedItem.id
        }
    }
}
