//
//  Top100AlbumsTests.swift
//  Top100AlbumsTests
//
//  Created by chanakkya mati on 1/5/21.
//

import XCTest
@testable import Top100Albums

class AlbumsFeedViewModelTests: XCTestCase {

    lazy var sut = AlbumsFeedViewModel(networkDependency: mockNetworkDependency)
    var mockNetworkDependency = MockAlbumFeedProvider()

    override func setUpWithError() throws {
        mockNetworkDependency = MockAlbumFeedProvider()
        sut = AlbumsFeedViewModel(networkDependency: mockNetworkDependency)
    }

    func test_AlbumsFeedViewModel() throws {
        mockNetworkDependency.shouldSucceed = true
        mockNetworkDependency.isCalled = false

        let success_expectation = expectation(description: "should succeed")
        sut.fetchAlbums { feed in
            success_expectation.fulfill()
        } failure: { _ in
            XCTFail("shouldn't fail")
            success_expectation.fulfill()
        }
        wait(for: [success_expectation], timeout: 1.0)

        XCTAssertTrue(mockNetworkDependency.isCalled)
        XCTAssertEqual(sut.albumFeed, AlbumFeed.mock)
        XCTAssertEqual(sut.numberOfAlbums, 2)
        XCTAssertEqual(sut.albums, AlbumFeed.mock.feed.results)
    }

}

extension AlbumFeed {
    static let mock: AlbumFeed = JsonLoad.getEntity(fromResource: "AlbumFeedResponse")
}

class MockAlbumFeedProvider: AlbumsProviderType {
    var shouldSucceed = true
    var isCalled = false
    func getTop100Albums(success: @escaping (AlbumFeed) -> Void, failure: @escaping (Error) -> Void) {
        isCalled = true
        guard shouldSucceed else {
            failure(HttpRequestHandler.NetworkError.serverError(nil, nil))
            return
        }
        success(AlbumFeed.mock)
    }


}
