//
//  TableViewDataSource.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/24/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
    typealias CellConfigurator = (Model, UITableViewCell) -> (Void)
    
    var models: [Model]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model, cell)
        return cell
    }
}

extension TableViewDataSource where Model == Item {
    static func make(for items: [Item],
                     reuseIdentifier: String = K.itemReusableCellIdentifier) -> TableViewDataSource {
        return TableViewDataSource(
            models: items,
            reuseIdentifier: reuseIdentifier
        ) { (item, cell) in
            let itemCell = cell as! ItemCell
            itemCell.nameLabel.text = item.title
            itemCell.subLabel.text = item.subtitle
            itemCell.coverArtBackgroundView.backgroundColor = item.coverArtLightColor
            itemCell.coverArtImageView.image = UIImage(systemName: item.coverArtImageName)
            itemCell.coverArtImageView.tintColor = item.coverArtDarkColor
        }
    }
}
