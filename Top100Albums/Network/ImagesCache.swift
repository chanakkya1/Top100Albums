//
//  ImagesCache.swift
//  Top100Albums
//
//  Created by chanakkya mati on 1/10/21.
//

import Foundation
import UIKit

// TODO: You can cache the images on the file system (Caches directory) as well.
final class ImageCache {
    static let shared = ImageCache()

    // In memory cache.
    private let cache = NSCache<NSURL, UIImage>()
    private var loadsInProgress = [URL: URLSessionDataTask]()

    private let session: URLSession = {
        let configuration: URLSessionConfiguration  = {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForRequest = 40.0
            configuration.httpMaximumConnectionsPerHost = 4
            return configuration
        }()

        return URLSession(configuration: configuration)
    }()

    private init() { }

    func load(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }

        guard loadsInProgress[url] == nil else {
            return
        }

        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }

            guard let imageData = data,
                  let image = UIImage(data: imageData),
                  error == nil else {
                DispatchQueue.main.async {
                    self.loadsInProgress[url] = nil
                    completion(nil)
                }
                return
            }

            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                self.loadsInProgress[url] = nil
                completion(image)
            }
        }

        loadsInProgress[url] = dataTask
        dataTask.resume()
    }

    func cancelLoad(for url: URL) {
        loadsInProgress[url]?.cancel()
        loadsInProgress[url] = nil
    }

}

