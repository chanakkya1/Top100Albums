//
//  XCTest+JSON.swift
//  Top100AlbumsTests
//
//  Created by chanakkya mati on 1/11/21.
//

import Foundation
import XCTest

class JsonLoad {
    static func getData(forResource resource: String) -> Data {
        let bundle = Bundle.init(for: self)

        guard let filePath = bundle.url(forResource: resource, withExtension: "json") else {
            fatalError("\(resource).json does not exist")
        }
        guard let data = try? Data(contentsOf: filePath) else {
            fatalError("Could not convert the contents of \(filePath) to Data")
        }

        return data
    }

    static func getEntity<T>(fromResource resource: String) -> T where T: Decodable {
        let data = self.getData(forResource: resource)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode entity with error: \(error)")
        }
    }
}
