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
	let total: Int
	let photo: [Photo]
}

extension PhotoPage {
	static var empty: PhotoPage {
		PhotoPage(
			page: 1,
			pages: 1,
			perpage: 0,
			total: 0,
			photo: []
		)
	}
}
