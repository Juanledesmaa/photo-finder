//
//  PhotoListAPIConfiguration.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import XCTest
@testable import Photo_Finder

final class PhotoListAPIConfigurationTests: XCTestCase {

	func test_makeSearchPhotosRequest_generatesValidRequest() {
		let mock = MockConfiguration(
			baseUrl: "https://mock.api/",
			apiKey: "mock_key",
			format: "json",
			path: "path/",
			safeSearch: "1"
		)
		
		let config = PhotoListAPIConfiguration(configuration: mock)
		let request = config.makeSearchPhotosRequest(searchTerm: "sunset", page: 2, perPage: 25, method: .photosGetRecent)
		
		XCTAssertNotNil(request)
		XCTAssertEqual(request?.httpMethod, "GET")
		
		guard let url = request?.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
			XCTFail("Invalid URL in request")
			return
		}
		
		let queryItems = components.queryItems ?? []
		let queryDict = Dictionary(uniqueKeysWithValues: queryItems.map { ($0.name, $0.value ?? "") })
		
		XCTAssertEqual(components.scheme, "https")
		XCTAssertEqual(components.host, "mock.api")
		XCTAssertEqual(components.path, "/path/")
		
		XCTAssertEqual(queryDict["api_key"], "mock_key")
		XCTAssertEqual(queryDict["format"], "json")
		XCTAssertEqual(queryDict["text"], "sunset")
		XCTAssertEqual(queryDict["page"], "2")
		XCTAssertEqual(queryDict["per_page"], "25")
		XCTAssertEqual(queryDict["safe_search"], "1")
		XCTAssertEqual(queryDict["method"], "flickr.photos.getRecent")
	}

	func test_makeSearchPhotosRequest_returnsNil_whenURLIsInvalid() {
		let mock = MockConfiguration(baseUrl: "ht!tp://[::1::]/nope", path: "invalid-path")
		let config = PhotoListAPIConfiguration(configuration: mock)
		let request = config.makeSearchPhotosRequest(searchTerm: "sunset")
		
		XCTAssertNil(request)
	}
}
