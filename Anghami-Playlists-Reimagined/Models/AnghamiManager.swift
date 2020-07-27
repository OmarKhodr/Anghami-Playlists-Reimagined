//
//  AnghamiManager.swift
//  Anghami-Playlists-Reimagined
//
//  Created by Omar Khodr on 7/7/20.
//  Copyright © 2020 Omar Khodr. All rights reserved.
//

import Foundation

protocol AnghamiManagerDelegate {
    func didFailWithError(_ manager: AnghamiManager, _ error: Error)
    func didGetItems(_ manager: AnghamiManager, _ items: [Item], _ type: RequestType)
}

enum RequestType: Int {
    case Playlists
    case Albums
    case Artists
}

class AnghamiManager {
    
    var delegate: AnghamiManagerDelegate?
    
    func performRequest(with urlString: String, type: RequestType) {
        if let url = URL(string: urlString) {
            let configuration: URLSessionConfiguration = .default
            configuration.httpAdditionalHeaders =
            [
                    "XAT": "interns",
                    "XATH": "97d22cfa8c579e1726e5b198"
            ]
            let session = URLSession(configuration: configuration)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(self, error)
                    return
                }
                if let safeData = data {
//                    print(String(decoding: safeData, as: UTF8.self))
                    var items: [Item]?
                    switch type {
                    case .Playlists:
                        items = self.buildPlaylistModels(data: safeData)
                    case .Albums:
                        items = self.buildAlbumModels(data: safeData)
                    case .Artists:
                        items = self.buildArtistModels(data: safeData)
                    }
                    if let items = items {
                        self.delegate?.didGetItems(self, items, type)
                    }
                }
            }
            task.resume()
        }
    }
    
    func buildPlaylistModels(data: Foundation.Data) -> [Item]?  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PlaylistsData.self, from: data)
            var models: [Item] = []
            for playlist in decodedData.playlists {
                models.append(Item(from: playlist))
            }
            return models
        } catch {
            print("Couldn't build Playlist Models: \(error)")
            return nil
        }
    }
    
    func buildAlbumModels(data: Foundation.Data) -> [Item]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([AlbumData].self, from: data)
            var models: [Item] = []
            for album in decodedData {
                models.append(Item(from: album))
            }
            return models
            
        } catch {
            print("Couldn't build Album Models: \(error)")
            return nil
        }
    }
    
    func buildArtistModels(data: Foundation.Data) -> [Item]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([ArtistData].self, from: data)
            var models: [Item] = []
            for album in decodedData {
                models.append(Item(from: album))
            }
            return models
            
        } catch {
            print("Couldn't build Artist Models: \(error)")
            return nil
        }
    }
    
}
