//
//  AlbumDetailViewModel.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/11/21.
//

import Foundation
import UIKit

class AlbumsDetailViewModel {
    private let album: Album
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    private let outputDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    private let imageCache = ImageCache.shared

    init(album: Album) {
        self.album = album
    }


}

extension AlbumsDetailViewModel {
    var albumName: String {
        album.name
    }
    var albumNameField: String {
       "Album Name:  \(albumName)"
    }

    var artistName: String {
       "Artist Name: \(album.artistName)"
    }

    var copyright: String {
        album.copyright
    }

    var genre: String {
       "Genres: \(album.genres.map(\.name).joined(separator: ", "))"
    }

    var releseDate: String {
        guard let date = dateFormatter.date(from: album.releaseDate) else {
            return album.releaseDate
        }
        return "Released On: \(outputDateFormatter.string(from: date))"
    }

    var itunesStoreLink: URL {
        album.artistUrl
    }

    func getImage(completion: @escaping (UIImage?) -> Void) {
        imageCache.load(url: album.artworkUrl100, completion: completion)
    }
}
