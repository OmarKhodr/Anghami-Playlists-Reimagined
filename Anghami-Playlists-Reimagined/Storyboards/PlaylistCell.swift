//
//  PlaylistCell.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/11/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class PlaylistCell: UITableViewCell {

    @IBOutlet weak var coverArtBackgroundView: UIView!
    @IBOutlet weak var coverArtImageView: UIImageView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playlistCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        coverArtBackgroundView.layer.cornerRadius = 8
        coverArtBackgroundView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
