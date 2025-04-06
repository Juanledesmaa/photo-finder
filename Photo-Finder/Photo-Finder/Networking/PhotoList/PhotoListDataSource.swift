//
//  PhotoListDataSource.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

protocol PhotoListDataSource {
	func fetchPhotos(
		for searchTerm: String
	) async throws -> PhotosSearchResponse
}
