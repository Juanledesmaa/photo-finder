//
//  MockConfiguration.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

import Foundation
@testable import Photo_Finder

final class MockConfiguration: APIConfigurationProtocol {
	var baseUrl: String
	var apiKey: String
	var format: String
	var path: String
	var safeSearch: String

	init(
		baseUrl: String = "https://mock.base.url",
		apiKey: String = "mock_api_key",
		format: String = "json",
		path: String = "services/rest",
		safeSearch: String = "1"
	) {
		self.baseUrl = baseUrl
		self.apiKey = apiKey
		self.format = format
		self.path = path
		self.safeSearch = safeSearch
	}
}
