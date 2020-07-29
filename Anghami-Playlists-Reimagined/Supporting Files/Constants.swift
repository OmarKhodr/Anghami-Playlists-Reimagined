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
    static let itemReusableCellIdentifier = "itemCell"
    static let itemCellNibName = "ItemCell"
    
    static let likedPlaylistName = "$1234567890LIKED#"
    static let downloadsPlaylistName = "$1234567890DOWNLOADED#"
    static let playlistNameDict = [
        "$1234567890LIKED#": "Likes",
        "$1234567890DOWNLOADED#": "Downloads"
    ]
    static let nameDict = [
        "Likes": "$1234567890LIKED#",
        "Downloads": "$1234567890DOWNLOADED#"
    ]
    static let coverArtDict: [String: (UIColor, UIColor, String)] = [
        "$1234567890LIKED#": K.Colors.likesCoverArt,
        "$1234567890DOWNLOADED#": K.Colors.downloadsCoverArt
    ]
    
    struct Colors {
        static let likesCoverArt = (#colorLiteral(red: 0.3529411765, green: 0.3803921569, blue: 0.9607843137, alpha: 1), UIColor(named: "likesLight")!, "heart.fill")
        static let downloadsCoverArt = (#colorLiteral(red: 0.2235294118, green: 0.537254902, blue: 0.8392156863, alpha: 1), UIColor(named: "downloadsLight")!, "arrow.down.circle.fill")
        static let playlistCoverArt = (#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9803808331, green: 0.9128970504, blue: 0.9070027471, alpha: 1), "music.note.list")
        static let albumCoverArt = (#colorLiteral(red: 0.03529411765, green: 0.5176470588, blue: 0.8901960784, alpha: 1), #colorLiteral(red: 0.4549019608, green: 0.7254901961, blue: 1, alpha: 1), "rectangle.stack.fill")
        static let artistCoverArt = (#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9803808331, green: 0.9128970504, blue: 0.9070027471, alpha: 1), "music.note.list")
    }
    
    struct URLs {
        static let userPlaylists = ""
        static let userAlbums = ""
        static let artistAlbums = ""
    }
}
