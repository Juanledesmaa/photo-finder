//
//  NetworkClient.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

final class NetworkClient: NetworkClientProtocol {
	
	private static let sharedSession = URLSession.shared
	private let session: URLSessionProtocol
	
	init(session: URLSessionProtocol = sharedSession) {
		self.session = session
	}

	func request<T: Decodable>(
		url: URL,
		method: HTTPMethod = .get
	) async throws -> T {
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		
		let (data, response) = try await session.data(for: request)
		
		guard let httpResponse = response as? HTTPURLResponse else {
			throw APIError.invalidResponse
		}
		
		guard (200...299).contains(httpResponse.statusCode) else {
			throw APIError.invalidResponse
		}

		if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data),
		   apiError.stat == "fail" {
			throw APIError.flickrError(code: apiError.code, message: apiError.message)
		}

		do {
			let jsonDecoder = JSONDecoder()
			jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
			return try jsonDecoder.decode(T.self, from: data)
		} catch {
			let responseString = String(data: data, encoding: .utf8) ?? "Unreadable Data"
			print("Decoding Failed for URL: \(url) | Response: \(responseString)")
			throw APIError.decodingFailed(error)
		}
	}
}
