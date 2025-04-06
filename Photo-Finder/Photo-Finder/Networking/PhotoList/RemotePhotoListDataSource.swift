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
	
	private struct Constants {
		static let defaultSearchTerm = "sunset"
	}
	
	init(
		networkClient: NetworkClientProtocol,
		apiConfiguration: PhotoListAPIConfiguration
	) {
		self.networkClient = networkClient
		self.apiConfiguration = apiConfiguration
	}
	
	func fetchPhotos(
		for searchTerm: String = Constants.defaultSearchTerm
	) async throws -> PhotosSearchResponse {
		guard let url = apiConfiguration
			.makeSearchPhotosRequest(searchTerm: searchTerm)?.url else {
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
