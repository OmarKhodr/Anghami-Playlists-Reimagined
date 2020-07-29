//
//  PlaylistSongData.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/29/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import Foundation

struct PlaylistSongData: Codable {
    let data: [SongData]
}

struct AlbumSongData: Codable {
    let songs: [SongData]
}

struct SongData: Codable {
    let id: String
    let title: String
    let artist: String
    let year: String
}
