//
//  MockURLSession.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import Foundation
@testable import Photo_Finder

final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
	var mockData: Data = Data()
	var mockResponse: URLResponse = HTTPURLResponse(
		url: URL(string: "https://mock")!,
		statusCode: 200,
		httpVersion: nil,
		headerFields: nil
	)!
	var shouldThrow = false

	func data(for request: URLRequest) async throws -> (Data, URLResponse) {
		if shouldThrow {
			throw URLError(.notConnectedToInternet)
		}
		return (mockData, mockResponse)
	}
}
