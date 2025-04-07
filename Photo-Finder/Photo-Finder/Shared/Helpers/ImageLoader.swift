//
//  ImageLoader.swift
//  Photo-Finder
//
//  Created by Juanito on 4/6/25.
//

import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
	@Published var phase: AsyncImagePhase = .empty

	private let url: URL?
	private let urlSession: URLSessionProtocol
	private let cache: URLCache
	private let placeholder: Image

	private static let defaultCache = URLCache(
		memoryCapacity: 100 * 1024 * 1024,
		diskCapacity: 500 * 1024 * 1024,
		diskPath: "PhotoList-imagesCache"
	)

	private static let imageSession: URLSession = {
		let configuration = URLSessionConfiguration.default
		configuration.requestCachePolicy = .useProtocolCachePolicy
		return URLSession(configuration: configuration)
	}()

	init(
		url: URL?,
		placeholder: Image = Image(systemName: "photo"),
		phase: AsyncImagePhase = .empty,
		urlSession: URLSessionProtocol = imageSession,
		cache: URLCache = defaultCache
	) {
		self.url = url
		self.phase = phase
		self.placeholder = placeholder
		self.urlSession = urlSession
		self.cache = cache
	}

	func load() async {
		phase = .empty

		guard let url else {
			updatePhase(.success(placeholder))
			return
		}

		let request = URLRequest(url: url)

		if let cachedResponse = cache.cachedResponse(for: request),
		   let cachedImage = UIImage(data: cachedResponse.data) {
			updatePhase(.success(Image(uiImage: cachedImage)))
			return
		}

		do {
			let (data, response) = try await urlSession.data(for: request)

			guard let httpResponse = response as? HTTPURLResponse,
				  httpResponse.statusCode == 200 else {
				throw URLError(.badServerResponse)
			}

			if let image = UIImage(data: data) {
				cache.storeCachedResponse(
					CachedURLResponse(response: response, data: data),
					for: request
				)
				updatePhase(.success(Image(uiImage: image)))
			} else {
				throw URLError(.cannotDecodeContentData)
			}
		} catch {
			updatePhase(.success(placeholder))
		}
	}

	private func updatePhase(_ newPhase: AsyncImagePhase) {
		withAnimation(.easeIn(duration: 0.1)) {
			phase = newPhase
		}
	}
}
