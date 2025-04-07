//
//  NetworkClientTests.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import XCTest
@testable import Photo_Finder

final class NetworkClientTests: XCTestCase {
	
	func test_request_successfullyDecodes() async throws {
		let session = MockURLSession()
		session.mockData = """
		{ "value": 42 }
		""".data(using: .utf8)!

		let client = NetworkClient(session: session)

		struct Response: Decodable, Equatable { let value: Int }

		let result: Response = try await client.request(
			url: URL(string: "https://mock")!,
			decoder: { data in try JSONDecoder().decode(Response.self, from: data) }
		)

		XCTAssertEqual(result.value, 42)
	}

	func test_request_throwsOnDecodingError() async {
		let session = MockURLSession()
		session.mockData = Data()

		let client = NetworkClient(session: session)

		struct Response: Decodable { let value: Int }

		do {
			_ = try await client.request(
				url: URL(string: "https://mock")!,
				decoder: { data in try JSONDecoder().decode(Response.self, from: data) }
			)
			XCTFail("Expected decoding to fail")
		} catch {
			XCTAssertTrue(error is APIError)
		}
	}

	func test_request_throwsOnInvalidStatusCode() async {
		let session = MockURLSession()
		session.mockResponse = HTTPURLResponse(
			url: URL(string: "https://mock")!,
			statusCode: 404,
			httpVersion: nil,
			headerFields: nil
		)!

		let client = NetworkClient(session: session)

		struct Response: Decodable { let value: Int }

		do {
			_ = try await client.request(
				url: URL(string: "https://mock")!,
				decoder: { data in try JSONDecoder().decode(Response.self, from: data) }
			)
			XCTFail("Expected to throw invalidResponse")
		} catch {
			XCTAssertEqual(error as? APIError, APIError.invalidResponse)
		}
	}
	
	func test_request_throwsInvalidResponse_whenResponseIsNotHTTPURLResponse() async {
		let session = MockURLSession()
		session.mockResponse = URLResponse()
		session.mockData = Data()

		let client = NetworkClient(session: session)

		struct Dummy: Decodable { let value: Int }

		do {
			_ = try await client.request(
				url: URL(string: "https://mock.com")!,
				decoder: { data in try JSONDecoder().decode(Dummy.self, from: data) }
			)
			XCTFail("Expected to throw APIError.invalidResponse")
		} catch {
			XCTAssertEqual(error as? APIError, .invalidResponse)
		}
	}
	
	func test_request_throwsInvalidResponse_whenStatusCodeIsNotSuccessful() async {
		let session = MockURLSession()
		session.mockResponse = HTTPURLResponse(
			url: URL(string: "https://mock.com")!,
			statusCode: 404,
			httpVersion: nil,
			headerFields: nil
		)!
		session.mockData = Data()

		let client = NetworkClient(session: session)

		struct Dummy: Decodable { let value: Int }

		do {
			_ = try await client.request(
				url: URL(string: "https://mock.com")!,
				decoder: { data in try JSONDecoder().decode(Dummy.self, from: data) }
			)
			XCTFail("Expected to throw APIError.invalidResponse")
		} catch {
			XCTAssertEqual(error as? APIError, .invalidResponse)
		}
	}
	
	func test_request_throwsFlickrError_whenStatIsFail() async {
		let session = MockURLSession()
		session.mockData = """
		{
			"stat": "fail",
			"code": 100,
			"message": "Invalid API Key"
		}
		""".data(using: .utf8)!
		
		let client = NetworkClient(session: session)

		struct Dummy: Decodable { let value: Int }

		do {
			_ = try await client.request(
				url: URL(string: "https://mock.com")!,
				decoder: { _ in Dummy(value: 0) }
			)
			XCTFail("Expected to throw flickrError")
		} catch {
			XCTAssertTrue(error is APIError)
		}
	}
}
