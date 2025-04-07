//
//  Photo.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

// Data Model for each individual Photo Object obtained from the API Response.
struct Photo: Codable, Equatable, Identifiable {
	let id: String
	let owner: String
	let secret: String
	let server: String
	let farm: Int
	let title: String
	let ispublic: Int
	let isfriend: Int
	let isfamily: Int
}

extension Photo: ImageURLRepresentable {
	var imageURL: URL? {
		URL(
			string: "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
		)
	}
}
