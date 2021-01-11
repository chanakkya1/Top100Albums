//
//  Album.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/5/21.
//

import Foundation

class Album: Codable {
    let id: String
    let artistName: String
    let releaseDate: String
    let name: String
    let copyright: String
    let artistId: String
    let contentAdvisoryRating: String?
    let artistUrl: URL
    let artworkUrl100: URL
    let genres: [Genre]
    let url: URL
}

class Genre: Codable {
    let genreId: String
    let name: String
    let url: URL
}

class AlbumFeed: Codable {
    let feed: Feed

    struct Feed: Codable {
        let title: String
        let id: URL?
        let copyright: String?
        let country: String?
        let updated: String?
        let results: [Album]
    }
}
