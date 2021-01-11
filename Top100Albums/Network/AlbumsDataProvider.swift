//
//  AlbumsDataProvider.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/11/21.
//

import Foundation

protocol AlbumsProviderType {
    func getTop100Albums(success: @escaping (AlbumFeed) -> Void, failure: @escaping (Error) -> Void)
}


class AlbumsProvider: AlbumsProviderType {
    private let httpRequestHandler: HttpRequestHandlerType

    init(httpRequestHandler: HttpRequestHandlerType? = nil) {
        self.httpRequestHandler = httpRequestHandler ?? HttpRequestHandler()
    }

    struct API {
        static let getTopHundredAlbumUrl =
            URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")
    }

    func getTop100Albums(success: @escaping (AlbumFeed) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = API.getTopHundredAlbumUrl else {
            // handle by logging or failing or showing an error
            preconditionFailure("Url can't be nil")
        }
        let request = URLRequest(url: url)
        httpRequestHandler.jsonRequest(request) { (result: Result<AlbumFeed, Error>) in
            switch result {
            case .success(let albumFeed):
                success(albumFeed)
            case .failure(let error):
                failure(error)
            }
        }
    }

}
