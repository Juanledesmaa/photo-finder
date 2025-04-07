//
//  RemotePhotoListDataSource.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import Foundation

final class RemotePhotoListDataSource: PhotoListDataSource {
	let networkClient: NetworkClientProtocol
	let apiConfiguration: PhotoListAPIConfiguration
	
	init(
		networkClient: NetworkClientProtocol,
		apiConfiguration: PhotoListAPIConfiguration
	) {
		self.networkClient = networkClient
		self.apiConfiguration = apiConfiguration
	}
	
	func fetchPhotos(
		for searchTerm: String,
		page: Int
	) async throws -> PhotosSearchResponse {
		guard let url = apiConfiguration
			.makeSearchPhotosRequest(
				searchTerm: searchTerm,
				page: page,
				method: searchTerm.isEmpty ? .photosGetRecent : .photosSearch
			)?.url else {
			throw NSError(
				domain: "",
				code: -1,
				userInfo: [
					NSLocalizedDescriptionKey: "Invalid URL"
				]
			)
		}
		
		return try await networkClient.request(
			url: url,
			method: .get,
			decoder: DecoderUtility.jsonpDecoder()
		)
	}
}

// This is a stateless dataSource so it's safe to use as a Sendable.
extension RemotePhotoListDataSource: @unchecked Sendable {}
