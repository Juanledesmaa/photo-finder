//
//  AppConfiguration.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

private struct Constants {
	/// Due to project restrictions, the API key is stored in this file as a constant.
	/// While this is the safest available approach under current constraints,
	/// this key **should not be exposed in the app** in a production environment.
	/// The recommended practice is to secure it on a backend and proxy all requests.
	static let API_KEY = "6e9f68457a19912aa8a67408383165b4"
}

struct APIConfiguration: APIConfigurationProtocol {
	var apiKey: String = Constants.API_KEY
	var format: String {
		return bundle.object(
			forInfoDictionaryKey: "API_FORMAT"
		) as? String ?? "json"
	}
	var baseUrl: String {
		return bundle.object(
			forInfoDictionaryKey: "BASE_URL"
		) as? String ?? ""
	}
	
	var path: String {
		return bundle.object(
			forInfoDictionaryKey: "SERVICES_REST_PATH"
		) as? String ?? "/services/rest/"
	}
	
	var safeSearch: String {
		return bundle.object(
			forInfoDictionaryKey: "SAFE_SEARCH"
		) as? String ?? "1"
	}
	
	private let bundle: Bundle

	init(bundle: Bundle = .main) {
		self.bundle = bundle
	}
}
