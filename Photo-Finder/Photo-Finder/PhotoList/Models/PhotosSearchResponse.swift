//
//  PhotosSearchResponse.swift
//  Photo-Finder
//
//  Created by Juanito on 4/5/25.
//

/// The top-level response object from the Flickr API search request.
struct PhotosSearchResponse: Decodable {
	let photos: PhotoPage
	let stat: APIStatus
}
