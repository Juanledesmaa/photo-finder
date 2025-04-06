//
//  APIMethod.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import Foundation

/// Flickr API method name (e.g., `flickr.photos.search`). Required in every request.
/// Defines which operation to perform.
///
/// Refer to: https://www.flickr.com/services/api/ for a full list of supported methods.
enum APIMethod: String {
	case photosSearch = "flickr.photos.search"
	
	var queryItem: URLQueryItem {
		URLQueryItem(name: "method", value: rawValue)
	}
}
