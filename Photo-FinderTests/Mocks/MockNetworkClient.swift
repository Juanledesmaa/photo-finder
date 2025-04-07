//
//  MockNetworkClient.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import Foundation
@testable import Photo_Finder

final class MockNetworkClient: NetworkClientProtocol {
	var lastRequestedURL: URL?
	var expectedResponse: PhotosSearchResponse?

	func request<T>(url: URL, method: Photo_Finder.HTTPMethod, decoder: @escaping (Data) throws -> T) async throws -> T where T : Decodable {
		self.lastRequestedURL = url
		return expectedResponse as! T
	}
}
