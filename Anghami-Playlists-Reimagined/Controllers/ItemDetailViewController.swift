//
//  ItemDetailViewController.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/29/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemInfoView: UIView!
    @IBOutlet weak var coverArtBackgroundView: UIView!
    @IBOutlet weak var coverArtImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemArtistLabel: UILabel!
    @IBOutlet weak var itemNumSongsLabel: UILabel!
    @IBOutlet weak var itemYearLabel: UILabel!
    
    
    var dataSource: TableViewDataSource<Item>?
    
    var itemID: String!
    var requestType: RequestType!
    
    var coverArt: (UIColor, UIColor, String)!
    var itemTitle: String!
    var itemArtist: String!
    var itemNumSongs: String!
    var itemYear: String!
    
    var items: [Item] = [Item(from: ArtistData(id: "12321", name: "Lobster", namear: "Lobster"))]
    private let anghami = AnghamiManager()
    
    private let loadingVC = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor(named: "purple")
        
        setupItemInfo()
        
        //avoid clipping the item info view
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        anghami.delegate = self
        
        tableView.delegate = self
        tableView.rowHeight = 80.0
        tableView.register(UINib(nibName: K.itemCellNibName, bundle: nil), forCellReuseIdentifier: K.itemReusableCellIdentifier)
        
        add(loadingVC)
        fetchSongs()
    }
    
    func setupItemInfo() {
        coverArtBackgroundView.backgroundColor = coverArt.0
        coverArtImageView.tintColor = coverArt.1
        coverArtImageView.image = UIImage(systemName: coverArt.2)
        itemTitleLabel.text = itemTitle
        itemArtistLabel.text = itemArtist
        itemNumSongsLabel.text = itemNumSongs
        itemYearLabel.text = itemYear
    }
    
    func fetchSongs() {
        var url = "https://bus.anghami.com/public/"
        if requestType == .Playlist {
            url += "playlist/data?playlist_id="
        } else if requestType == .Album {
            url += "album?album_id="
        }
        url += itemID!
        anghami.performRequest(with: url, type: requestType)
    }

}

extension ItemDetailViewController: AnghamiManagerDelegate {
    func didFailWithError(_ manager: AnghamiManager, _ error: Error) {
        print(error)
    }
    
    func didGetItems(_ manager: AnghamiManager, _ items: [Item], _ type: RequestType) {
        for item in items {
            self.items.append(item)
        }
        dataSource = .make(for: items, reuseIdentifier: K.itemReusableCellIdentifier)
        DispatchQueue.main.async {
            self.loadingVC.remove()
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}

extension ItemDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
