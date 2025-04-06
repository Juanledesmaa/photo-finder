//
//  PhotoPage.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

/// Data Model for the current search results page used for indexing on the pagination.
struct PhotoPage: Codable {
	let page: Int
	let pages: Int
	let perpage: Int
	let total: String
	let photo: [Photo]
}
