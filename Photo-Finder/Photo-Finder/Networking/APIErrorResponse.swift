//
//  APIErrorResponse.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

struct APIErrorResponse: Decodable {
	let stat: String
	let code: Int
	let message: String
}
