//
//  PhotoListAPIConfiguration.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

final class PhotoListAPIConfiguration {
	private let configuration: APIConfigurationProtocol
	
	init(configuration: APIConfigurationProtocol) {
		self.configuration = configuration
	}
	
	func makeSearchPhotosRequest(
		searchTerm: String,
		page: Int = 1,
		perPage: Int = 100,
		method: APIMethod = .photosSearch
	) -> URLRequest? {
		guard var components = URLComponents(
			string: configuration.baseUrl + "/services/rest/"
		) else {
			return nil
		}

		components.queryItems = [
			URLQueryItem(name: "api_key", value: configuration.apiKey),
			URLQueryItem(name: "format", value: configuration.format),
			URLQueryItem(name: "text", value: searchTerm),
			URLQueryItem(name: "page", value: "\(page)"),
			URLQueryItem(name: "per_page", value: "\(perPage)"),
			method.queryItem,
		]

		guard let componentsURL = components.url else { return nil }
		var request = URLRequest(url: componentsURL)
		request.httpMethod = HTTPMethod.get.rawValue
		request.applyDefaultHeaders()
		return request
	}
}
