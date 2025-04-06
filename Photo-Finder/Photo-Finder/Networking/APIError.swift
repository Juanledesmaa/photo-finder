//
//  ApiError.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

enum APIError: Error, Equatable {
	case invalidResponse
	case decodingFailed(Error)
	case flickrError(code: Int, message: String)

	static func == (lhs: APIError, rhs: APIError) -> Bool {
		switch (lhs, rhs) {
		case (.invalidResponse, .invalidResponse):
			return true
		case (.decodingFailed, .decodingFailed):
			return true
		case let (.flickrError(lhsCode, _), .flickrError(rhsCode, _)):
			return lhsCode == rhsCode
		default:
			return false
		}
	}
}
