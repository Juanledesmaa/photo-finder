//
//  PhotosSearchResponse+Extension.swift
//  Photo-Finder
//
//  Created by Juanito on 4/7/25.
//

@testable import Photo_Finder

extension PhotosSearchResponse {
	static let mock = PhotosSearchResponse(
		photos: PhotoPage(
			page: 1,
			pages: 1,
			perpage: 1,
			total: 1,
			photo: [
				Photo(
					id: "1",
					owner: "owner",
					secret: "secret",
					server: "server",
					farm: 1,
					title: "Mock",
					ispublic: 1,
					isfriend: 0,
					isfamily: 0
				)
			]
		),
		stat: .ok
	)

	static let empty = PhotosSearchResponse(
		photos: .empty,
		stat: .ok
	)
}
