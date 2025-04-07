//
//  Decoder.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import Foundation

struct DecoderUtility {
	static func defaultDecoder<T: Decodable>() -> (Data) throws -> T {
		{ data in
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			return try decoder.decode(T.self, from: data)
		}
	}
	
	static func jsonpDecoder<T: Decodable>(
		callbackWrapper: String = "jsonFlickrApi"
	) -> (Data) throws -> T {
		{ data in
			guard var jsonString = String(data: data, encoding: .utf8),
				  jsonString.hasPrefix("\(callbackWrapper)("),
				  jsonString.hasSuffix(")") else {
				throw APIError.decodingFailed(
					NSError(
						domain: "Invalid JSONP",
						code: 0
					)
				)
			}
			
			jsonString.removeFirst(callbackWrapper.count + 1)
			jsonString.removeLast()
			
			guard let cleanData = jsonString.data(using: .utf8) else {
				throw APIError.decodingFailed(
					NSError(
						domain: "Re-encoding JSON failed",
						code: 0
					)
				)
			}
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			return try decoder.decode(T.self, from: cleanData)
		}
	}
	
}
