//
//  Photo.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

// Data Model for each individual Photo Object obtained from the API Response.
struct Photo: Codable {
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
