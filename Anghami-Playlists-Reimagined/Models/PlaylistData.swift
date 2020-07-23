//
//  Playlist.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/7/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import Foundation

struct PlaylistsData: Codable {
    let playlists: [PlaylistData]
}

struct PlaylistData: Codable {
    let id: String
    let name: String
    let CoverArtID: String
    let count: Int
    let coverArt: String
}
