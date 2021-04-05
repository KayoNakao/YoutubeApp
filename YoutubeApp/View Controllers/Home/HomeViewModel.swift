//
//  HomeViewModel.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-02.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import Foundation
import PromiseKit

class HomeViewModel {
    
    private let manager = ServiceManager()
    private var playlists: Playlist?
    var currentSort = SortOption.recent
    
    var items: [Playlist.Item]? {
        guard let playlists = playlists else { return nil }
        switch currentSort {
        case .recent: return playlists.items.sorted(by: { $0.snippet.date > $1.snippet.date })
        case .aToZ: return playlists.items.sorted(by: { $0.snippet.title > $1.snippet.title })
        case .zToA: return playlists.items.sorted(by: { $0.snippet.title < $1.snippet.title })
        }
    }
    
    var numberOfRows: Int {
        playlists?.items.count ?? 0
    }
    
    func getItem(at index: Int) -> Playlist.Item? {
        self.items?[index] ?? nil
    }
    
    func getPlaylists() -> Promise<Void> {
        return Promise { seal in
            manager.getPlaylists()
                .done { playlists in
                    self.playlists = playlists
                    seal.fulfill(())
                }.catch { error in
                    seal.reject(error)
                }
        }
    }
    
    func setSortOption(_ option: SortOption) {
        currentSort = option
    }
}
