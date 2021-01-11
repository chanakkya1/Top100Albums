//
//  AlbumsFeedViewModel.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/11/21.
//

import Foundation

protocol AlbumsFeedViewModelType: class {
    var numberOfAlbums: Int { get }
    var albums: [Album] { get }
    var OnFeedUpdate: (() -> ())? { get set }
    func album(at indexPath: IndexPath) -> Album
    func fetchAlbums(success: @escaping (AlbumFeed) -> Void, failure: @escaping (Error) -> Void)
}

class AlbumsFeedViewModel: AlbumsFeedViewModelType {

    private let networkDependency: AlbumsProviderType
    
    private(set) var albumFeed: AlbumFeed? {
        didSet {
            OnFeedUpdate?()
        }
    }
    var OnFeedUpdate: (() -> ())?

    init(networkDependency: AlbumsProviderType = AlbumsProvider()) {
        self.networkDependency = networkDependency
    }

    func fetchAlbums(success: @escaping (AlbumFeed) -> Void, failure: @escaping (Error) -> Void) {
        networkDependency.getTop100Albums { [weak self] feed in
            guard let self = self else { return }
            self.albumFeed = feed
            success(feed)
        } failure: { (error) in
            failure(error)
        }
    }
}

extension AlbumsFeedViewModel {
    var numberOfAlbums: Int {
        albums.count
    }

    var albums: [Album] {
        albumFeed?.feed.results ?? []
    }

    func album(at indexPath: IndexPath) -> Album {
        albums[indexPath.row]
    }
}
