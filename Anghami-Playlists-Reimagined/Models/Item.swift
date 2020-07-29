//
//  Item.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/27/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import UIKit

class Item {
    let id: String
    let title: String
    let subtitle: String
    let coverArtDarkColor: UIColor
    let coverArtLightColor: UIColor
    let coverArtImageName: String
    
    init(from playlist: PlaylistData) {
        id = playlist.id
        if let special = K.playlistNameDict[playlist.name] {
            title = special.localized
        } else {
            title = playlist.name
        }
        let count = playlist.count
        subtitle = "\(count) " + ("song" + (count != 1 ? "s" : "")).localized
        let coverArt = K.coverArtDict[playlist.name] ?? K.Colors.playlistCoverArt
        coverArtDarkColor = coverArt.0
        coverArtLightColor = coverArt.1
        coverArtImageName = coverArt.2
    }
    
    init(from album: AlbumData) {
        id = album.id
        title = album.title
        subtitle = album.artistname
        coverArtImageName = "rectangle.stack.fill"
        coverArtDarkColor = #colorLiteral(red: 0.03529411765, green: 0.5176470588, blue: 0.8901960784, alpha: 1)
        coverArtLightColor = #colorLiteral(red: 0.4549019608, green: 0.7254901961, blue: 1, alpha: 1)
    }
    
    init(from artist: ArtistData) {
        id = artist.id
        title = artist.name
        subtitle = ""
        coverArtImageName = "person.fill"
        coverArtDarkColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.7882352941, alpha: 1)
        coverArtLightColor = #colorLiteral(red: 0.5058823529, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
    }
    
    init(from song: SongData) {
        id = song.id
        title = song.title
        subtitle = song.artist
        coverArtImageName = "music.note"
        coverArtDarkColor = #colorLiteral(red: 0.8823529412, green: 0.4392156863, blue: 0.3333333333, alpha: 1)
        coverArtLightColor = #colorLiteral(red: 0.9803921569, green: 0.6941176471, blue: 0.6274509804, alpha: 1)
    }
    
}
