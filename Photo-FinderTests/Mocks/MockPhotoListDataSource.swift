//
//  MockPhotoListDataSource.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import Foundation
@testable import Photo_Finder

final class MockPhotoListDataSource: PhotoListDataSourceProtocol {
	var mockResponse: PhotosSearchResponse = .mock
	var shouldThrow: Bool = false
	var lastSearchTerm: String?
	var lastPage: Int?

	func fetchPhotos(
		for searchTerm: String,
		page: Int
	) async throws -> PhotosSearchResponse {
		lastSearchTerm = searchTerm
		lastPage = page

		if shouldThrow {
			throw NSError(domain: "MockError", code: -1)
		}

		return mockResponse
	}
}

