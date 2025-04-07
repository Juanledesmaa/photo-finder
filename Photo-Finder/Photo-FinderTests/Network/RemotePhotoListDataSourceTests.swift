//
//  RemotePhotoListDataSourceTests.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import XCTest
@testable import Photo_Finder

final class RemotePhotoListDataSourceTests: XCTestCase {

	func test_fetchPhotos_withSearchTerm_callsSearchMethod() async throws {
		let client = MockNetworkClient()
		client.expectedResponse = .mock

		let config = MockConfiguration(
			baseUrl: "https://mockapi.com/",
			apiKey: "mockKey",
			format: "json",
			path: "/",
			safeSearch: "1"
		)
		let apiConfig = PhotoListAPIConfiguration(configuration: config)
		let dataSource = RemotePhotoListDataSource(
			networkClient: client,
			apiConfiguration: apiConfig
		)

		let result = try await dataSource.fetchPhotos(for: "sunset", page: 1)

		XCTAssertEqual(result.photos.photo.count, 1)
		XCTAssertNotNil(client.lastRequestedURL?.absoluteString)
		XCTAssertTrue(client.lastRequestedURL!.absoluteString.contains("method=flickr.photos.search"))
	}

	func test_fetchPhotos_withEmptySearchTerm_callsGetRecentMethod() async throws {
		let client = MockNetworkClient()
		client.expectedResponse = .mock

		let config = MockConfiguration(
			baseUrl: "https://mockapi.com/",
			apiKey: "mockKey",
			format: "json",
			path: "/",
			safeSearch: "1"
		)
		let apiConfig = PhotoListAPIConfiguration(configuration: config)
		let dataSource = RemotePhotoListDataSource(
			networkClient: client,
			apiConfiguration: apiConfig
		)

		let result = try await dataSource.fetchPhotos(for: "", page: 1)

		XCTAssertEqual(result.photos.photo.count, 1)
		XCTAssertTrue(client.lastRequestedURL!.absoluteString.contains("method=flickr.photos.getRecent"))
	}

	func test_fetchPhotos_invalidURL_throwsError() async {
		let config = MockConfiguration(baseUrl: "ht!tp://[::1::]/nope")
		let apiConfig = PhotoListAPIConfiguration(configuration: config)
		let client = MockNetworkClient()

		let dataSource = RemotePhotoListDataSource(
			networkClient: client,
			apiConfiguration: apiConfig
		)

		do {
			_ = try await dataSource.fetchPhotos(for: "sunset", page: 1)
			XCTFail("Expected error for invalid URL")
		} catch {
			XCTAssertEqual((error as NSError).localizedDescription, "Invalid URL")
		}
	}
}
