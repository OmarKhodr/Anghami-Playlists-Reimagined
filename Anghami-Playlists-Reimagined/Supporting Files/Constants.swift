//
//  Constants.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/11/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import Foundation
import UIKit

struct K {
    static let playlistReusableCellIdentifier = "playlistCell"
    static let playlistCellNibName = "PlaylistCell"
    
    static let likedPlaylistName = "$1234567890LIKED#"
    static let downloadsPlaylistName = "$1234567890DOWNLOADED#"
    static let playlistNameDict = [
        "$1234567890LIKED#": "Likes",
        "$1234567890DOWNLOADED#": "Downloads"
    ]
    
    struct Colors {
        static let likesCoverArt = (#colorLiteral(red: 0.3529411765, green: 0.3803921569, blue: 0.9607843137, alpha: 1), #colorLiteral(red: 0.9294117647, green: 0.9333333333, blue: 0.9725490196, alpha: 1), "heart.fill")
        static let downloadsCoverArt = (#colorLiteral(red: 0.2235294118, green: 0.537254902, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.9529411765, blue: 0.9882352941, alpha: 1), "arrow.down.circle.fill")
        static let playlistCoverArt = (#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9803808331, green: 0.9128970504, blue: 0.9070027471, alpha: 1), "music.note.list")
    }
}
