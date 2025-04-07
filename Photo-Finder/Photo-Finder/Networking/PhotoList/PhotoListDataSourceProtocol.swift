//
//  PhotoListDataSource.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

protocol PhotoListDataSourceProtocol: Sendable {
	func fetchPhotos(
		for searchTerm: String,
		page: Int
	) async throws -> PhotosSearchResponse
}
