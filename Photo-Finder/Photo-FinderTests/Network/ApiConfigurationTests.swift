//
//  ApiConfigurationTests.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import XCTest
@testable import Photo_Finder

final class APIConfigurationTests: XCTestCase {

	func testAPIKey_isEqualToExpectedConstant() {
		let config = APIConfiguration(bundle: MockBundle(mockInfo: [:]))
		XCTAssertEqual(config.apiKey, "6e9f68457a19912aa8a67408383165b4")
	}

	func testBaseUrl_returnsValueFromBundle() {
		let mock = MockBundle(mockInfo: ["BASE_URL": "https://mock.base.url"])
		let config = APIConfiguration(bundle: mock)
		XCTAssertEqual(config.baseUrl, "https://mock.base.url")
	}

	func testBaseUrl_fallbacksToEmptyString() {
		let config = APIConfiguration(bundle: MockBundle(mockInfo: [:]))
		XCTAssertEqual(config.baseUrl, "")
	}

	func testFormat_returnsValueFromBundle() {
		let mock = MockBundle(mockInfo: ["API_FORMAT": "xml"])
		let config = APIConfiguration(bundle: mock)
		XCTAssertEqual(config.format, "xml")
	}

	func testFormat_fallbacksToJson() {
		let config = APIConfiguration(bundle: MockBundle(mockInfo: [:]))
		XCTAssertEqual(config.format, "json")
	}

	func testPath_returnsValueFromBundle() {
		let mock = MockBundle(mockInfo: ["SERVICES_REST_PATH": "/mock/path/"])
		let config = APIConfiguration(bundle: mock)
		XCTAssertEqual(config.path, "/mock/path/")
	}

	func testPath_fallbacksToDefault() {
		let config = APIConfiguration(bundle: MockBundle(mockInfo: [:]))
		XCTAssertEqual(config.path, "/services/rest/")
	}

	func testSafeSearch_returnsValueFromBundle() {
		let mock = MockBundle(mockInfo: ["SAFE_SEARCH": "3"])
		let config = APIConfiguration(bundle: mock)
		XCTAssertEqual(config.safeSearch, "3")
	}

	func testSafeSearch_fallbacksToDefault() {
		let config = APIConfiguration(bundle: MockBundle(mockInfo: [:]))
		XCTAssertEqual(config.safeSearch, "1")
	}
}

