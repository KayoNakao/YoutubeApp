//
//  ServiceManager.swift
//  YoutubeApp
//
//  Created by Kayo Nakao on 2021-03-31.
//  Copyright © 2021 Guarana Technologies Inc. All rights reserved.
//

import Foundation
import PromiseKit
import GoogleSignIn

enum Endpoint {
    static let apiKey = Environment.getValue(forKey: .googleApiKey)
    static let base = "https://www.googleapis.com/youtube/v3"
    
    case getPlaylists
    
    var stringValue: String {
        switch self {
        case .getPlaylists: return Endpoint.base + "/playlists?part=snippet%2CcontentDetails&maxResults=25&mine=true&key=\(Endpoint.apiKey)"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}

class ServiceManager {
    typealias ResultHandler = (_ result: Result<Data>) -> Void
    private let session = URLSession.shared

    func makeRequest(for endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        let token = AuthManager.authentication?.accessToken ?? ""
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return request
    }
    
    func request(endpoint: Endpoint, parameters params: Any? = nil) -> Promise<Data> {
        return Promise { seal in
            let request = makeRequest(for: endpoint)
            
            session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    seal.reject(error ?? YTError.unknown)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 300 {
                    seal.fulfill(data)
                } else {
                    print(String(data: data, encoding: .utf8))
                    let error = RError(data: data)
                    seal.reject(error)
                }
            }.resume()
        }
    }
    
    func getPlaylists() -> Promise<Playlist> {
        return Promise { seal in
            guard let fileURL = Bundle.main.url(forResource: "playlists", withExtension: "json"), let data = try? Data(contentsOf: fileURL) else {
                seal.reject(YTError.unknown)
                return
            }

            do {
                let playlists = try JSONDecoder().decode(Playlist.self, from: data)
                seal.fulfill(playlists)
            } catch {
                seal.reject(error)
            }
        }
//        request(endpoint: .getPlaylists)
//            .done { data in
//                print(String(data: data, encoding: .utf8))
//
//            }.catch { error in
//                print(error)
//            }
                
    }
}

public class RError: Error {
    public let data: Data
    
    init(data: Data) {
        self.data = data
    }
}
