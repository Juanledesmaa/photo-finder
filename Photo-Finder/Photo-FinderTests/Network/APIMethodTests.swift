//
//  APIMethodTests.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import XCTest
@testable import Photo_Finder

final class APIMethodTests: XCTestCase {
	func test_photosSearch_queryItem() {
		let item = APIMethod.photosSearch.queryItem
		XCTAssertEqual(item.name, "method")
		XCTAssertEqual(item.value, "flickr.photos.search")
	}

	func test_photosGetRecent_queryItem() {
		let item = APIMethod.photosGetRecent.queryItem
		XCTAssertEqual(item.name, "method")
		XCTAssertEqual(item.value, "flickr.photos.getRecent")
	}
}
