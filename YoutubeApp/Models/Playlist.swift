//
//  Playlist.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-04-03.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import Foundation

struct Playlist: Codable {
    let items: [Item]
    let kind: String
    let etag: String
    let pageInfo: PageInfo
    let nextPageToken: String?
    let prevPageToken: String?
    
    struct PageInfo: Codable {
        let resultsPerPage: Int
        let totalResults: Int
    }
    
    struct Item: Codable {
        let snippet: Snippet
        let contentDetails: ContentDetails
        let kind: String
        let etag: String
        let id: String
        
        struct Snippet: Codable {
            let thumbnails: Thumbnails
            let title: String
            let channelId: String
            let publishedAt: String
            let channelTitle: String
            let localized: Localized
            let description: String
            
            var date: Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                return dateFormatter.date(from: publishedAt) ?? Date()
            }
            
            struct Thumbnails: Codable {
                let defaultData: ThumbnailInfo?
                let high: ThumbnailInfo?
                let medium: ThumbnailInfo?
                let max: ThumbnailInfo?
                let standard: ThumbnailInfo?
                
                enum CodingKeys: String, CodingKey {
                    case defaultData = "default"
                    case high
                    case medium
                    case max = "maxres"
                    case standard
                }
                
                struct ThumbnailInfo: Codable {
                    let url: String
                    let width: Int
                    let height: Int
                }
            }
            struct Localized: Codable {
                let description: String
                let title: String
            }
        }
        
        struct ContentDetails: Codable {
            let itemCount: Int
        }
    }
}
