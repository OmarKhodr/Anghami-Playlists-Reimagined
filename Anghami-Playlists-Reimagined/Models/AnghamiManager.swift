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
    func didGetPlaylists(_ manager: AnghamiManager, _ playlists: PlaylistsData)
}

class AnghamiManager {
    
    var delegate: AnghamiManagerDelegate?
    
    func performRequest(with urlString: String) {
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
                    print(String(decoding: safeData, as: UTF8.self))
                    if let playlists = self.buildPlaylistModel(data: safeData) {
                        self.delegate?.didGetPlaylists(self, playlists)
                    }
                }
            }
            task.resume()
        }
    }
    
    func buildPlaylistModel(data: Foundation.Data) -> PlaylistsData?  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PlaylistsData.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
}
