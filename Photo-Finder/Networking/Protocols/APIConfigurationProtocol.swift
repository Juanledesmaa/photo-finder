//
//  ConfigurationProtocol.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

import Foundation

protocol APIConfigurationProtocol {
	var baseUrl: String { get }
	var apiKey: String { get }
	var format: String { get }
	var path: String { get }

	// Flickr provides a way to filter out unsafe or NSFW content through
	// the API using the safe_search parameter
	var safeSearch: String { get }
}
