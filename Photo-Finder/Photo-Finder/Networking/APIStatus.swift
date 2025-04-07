//
//  FlickrAPIStatus.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

/// Represents the status of a Flickr API response.
///
/// According to Flickr’s API documentation, the `stat` field has only two possible values:
///
/// - `ok`: The request was successful, and the response contains valid data.
/// - `fail`: The request failed. The response will include an error code and message.
///
enum APIStatus: String, Decodable {
	case ok
	case fail
}
